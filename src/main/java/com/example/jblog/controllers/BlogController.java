package com.example.jblog.controllers;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.jblog.security.Auth;
import com.example.jblog.services.BlogService;
import com.example.jblog.vo.BlogVo;
import com.example.jblog.vo.CategoryVo;
import com.example.jblog.vo.CommentVo;
import com.example.jblog.vo.PostVo;
import com.example.jblog.vo.SearchVo;

@Controller
@RequestMapping("/blog")
public class BlogController {
	@Autowired
	private BlogService blogService;

	@Auth
	@RequestMapping(value = "/{userId}/admin/basicsetting", method = RequestMethod.GET)
	public String moveBasicSetting(Model model,@PathVariable("userId") String userId) {
		
		BlogVo blogVo = blogService.getBlogContent(userId);
		model.addAttribute("blogVo",blogVo);
		return "blog/basicsetting";
	}

	@Auth
	@RequestMapping(value = "/{userId}/admin/boardwriteform", method = RequestMethod.GET)
	public String moveBoardWrite(Model model, @PathVariable("userId") String userId) {
		List<CategoryVo> categoryVo = blogService.getCategoryList(userId);
		model.addAttribute("categoryVo", categoryVo);
		return "blog/boardwriteform";
	}

	@Auth
	@RequestMapping(value = "/{userId}/admin/categorysetting", method = RequestMethod.GET)
	public String moveCategorySetting(Model model, @PathVariable("userId") String userId) {
		List<CategoryVo> categoryVo = blogService.getCategoryList(userId);
		model.addAttribute("categoryVo", categoryVo);
		return "blog/categorysetting";
	}

	@Auth
	@RequestMapping(value = "/{userId}/admin/boardwrite", method = RequestMethod.POST)
	public String boardWriteAction(@PathVariable("userId") String userId, @ModelAttribute PostVo vo) {
		Map<String, Object> postMap = new HashMap<String, Object>();
		postMap.put("title", vo.getTitle());
		postMap.put("content", vo.getContent());
		postMap.put("categoryNo", vo.getCategoryNo());
		postMap.put("id", userId);

		boolean result = blogService.writePost(postMap);

		if (result) {
			return "redirect:/blog/" + userId + "/admin/boardwriteform";
		} else {
			return "blog/postfail";
		}
	}

	@Auth
	@RequestMapping(value = "/{userId}/admin/getCategoryList", method = RequestMethod.GET)
	@ResponseBody
	public List<CategoryVo> getCategoryList(@PathVariable("userId") String userId) {
		return blogService.getCategoryList(userId);
	}

	@Auth
	@RequestMapping(value = "/{userId}/admin/categoryadd", method = RequestMethod.POST)
	@ResponseBody
	public Object addCategory(@PathVariable("userId") String userId, @RequestParam("name") String name,
			@RequestParam("description") String description) {

		Map<String, Object> categoryMap = new HashMap<String, Object>();
		categoryMap.put("name", name);
		categoryMap.put("description", description);
		categoryMap.put("id", userId);

		boolean result = blogService.addCategory(categoryMap);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "success");
		map.put("data", result);

		return map;
	}

	@Auth
	@RequestMapping(value = "/{userId}/admin/categorydelete", method = RequestMethod.POST)
	@ResponseBody
	public Object deleteCategory(@PathVariable("userId") String userId, @RequestParam("no") String no) {
		Map<String, Object> categoryMap = new HashMap<String, Object>();
		categoryMap.put("no", no);
		categoryMap.put("id", userId);

		boolean result = blogService.deleteCategory(categoryMap);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("result", "success");
		map.put("data", result);

		return map;
	}

	@RequestMapping(value = "/{userId}", method = RequestMethod.GET)
	public String myBlog(@PathVariable("userId") String userId, Model model) {
		int page = 1;
		// 맨위의 글을 가져옴. (최신글)
		PostVo postVo = blogService.getPostNewestFirst(userId);
		
		int maxPage	= 1;
		int navStartPage = 1;
		Map<String, Object> postMap = new HashMap<String, Object>();
		postMap.put("userId", userId);
		postMap.put("currPage", page);	
		postMap.put("postPerPage", 3);
		
		List<CommentVo> commentVo;
		BlogVo blogVo = blogService.getBlogContent(userId);
		List<CategoryVo> categoryVo = blogService.getCategoryList(userId);
		
		// 전체 페이지수를 가져옴.
		maxPage = blogService.getMaxPageCount(3,userId); // 인자(postPerPage) : 한페이지당 몇개의 게시글을 보여줄지? 
		
		// 페이지에 맞는 게시글을 가져옴.
		List<PostVo> postListVo = blogService.getPostListFirst(postMap);
		
		navStartPage = (page - 1) / 5 * 5 + 1;
		
		if(postVo != null ){
			commentVo = blogService.getComments(postVo.getNo());
			model.addAttribute("commentVo", commentVo);
		}
		if (blogVo != null) {
			// 이름이 존재함
			model.addAttribute("blogVo", blogVo);
			model.addAttribute("categoryVo", categoryVo);
			model.addAttribute("postListVo", postListVo);
			model.addAttribute("postVo", postVo);
			model.addAttribute("userId", userId);
			
			model.addAttribute("currPage", page);
			model.addAttribute("postPerPage", 3);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("navStartPage", navStartPage);
			model.addAttribute("navPageCount", 5); // 네비게이션 갯수

			return "blog/blogmaindefault";
		} else {
			// 이름이 존재하지 않음.
			return "blog/blogNotFound";
		}
	}
	
	@Auth
	@RequestMapping(value = "/{userId}/admin/updatesetting", method = RequestMethod.POST)
	public String updateSetting(@PathVariable("userId") String userId, @RequestParam("logo") MultipartFile logoImg,
			@RequestParam("blogName") String blogName, Model model) {
		String saveFilename;
		Map<String, String> blogMap = new HashMap<String, String>();

		if (logoImg.isEmpty() && blogName.isEmpty()) {
			return "redirect:/blog/"+userId+"/admin/basicsetting";
		}

		// 이미지 파일 처리
		if (!(logoImg.isEmpty())) {
			saveFilename = blogService.updateSetting(logoImg);
			blogMap.put("logo", saveFilename);
		}

		// 블로그 이름 처리
		if (!(blogName.isEmpty())) {
			blogMap.put("title", blogName);
		}

		blogMap.put("id", userId);

		boolean result = blogService.updateBlogNameAndLogo(blogMap);

		if (result) {
			return "redirect:/blog/"+userId+"/admin/basicsetting";
		} else {
			return "blog/updateFail";
		}
	}

	@Auth
	@RequestMapping(value = "{userId}/addcomment", method = RequestMethod.POST)
	@ResponseBody
	public List<CommentVo> addAndGetCommentList(@PathVariable("userId") String userId,
			@RequestParam("content") String content, @RequestParam("postno") String postNo) {
		Map<String, Object> commentMap = new HashMap<String, Object>();
		commentMap.put("userId", userId);
		commentMap.put("postNo", postNo);
		commentMap.put("content", content);

		return blogService.getCommentList(commentMap);
	}
	

	@RequestMapping(value = "{userId}/getComment", method = RequestMethod.POST)
	@ResponseBody
	public List<CommentVo> getCommentList(@PathVariable("userId") String userId, @RequestParam("postNo") Long postNo) {

		return blogService.getComments(postNo);
	}

	@RequestMapping(value = "/category/{userId}/{categoryNo}", method = RequestMethod.GET)
	public String moveCategory(@PathVariable("userId") String userId, @PathVariable("categoryNo") Long no,
			Model model) {
		
		int maxPage	= 1;
		int navStartPage = 1;
		int page = 1;
		
		Map<String, Object> postMap = new HashMap<String, Object>();
		postMap.put("userId", userId);
		postMap.put("categoryNo", no);
		postMap.put("currPage", page);	
		postMap.put("postPerPage", 3);
		
		List<CommentVo> commentVo;
		
		List<PostVo> postListVo = blogService.getPostListCategory(postMap); // 필요한것 : userId , categoryNo , 
		maxPage = blogService.getMaxPageCountCategory(3,userId,no); // 인자(postPerPage) : 한페이지당 몇개의 게시글을 보여줄지? 
																	// no : 카테고리No
		BlogVo blogVo = blogService.getBlogContent(userId);
		List<CategoryVo> categoryVo = blogService.getCategoryList(userId);

		PostVo postVo = blogService.getPostNewest(postMap); 
		
		navStartPage = (page - 1) / 5 * 5 + 1;
		
		if(postVo != null) {
			commentVo = blogService.getComments(postVo.getNo());
			model.addAttribute("commentVo", commentVo);
		}
		
		if (blogVo != null) {
			// 이름이 존재함
			model.addAttribute("blogVo", blogVo);
			model.addAttribute("categoryVo", categoryVo);
			model.addAttribute("postListVo", postListVo);
			model.addAttribute("postVo", postVo);
			model.addAttribute("userId", userId);
			
			model.addAttribute("currPage", page);
			model.addAttribute("postPerPage", 3);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("navStartPage", navStartPage);
			model.addAttribute("navPageCount", 5); // 네비게이션 갯수

			return "blog/blogmain";
		} else {
			// 이름이 존재하지 않음.
			return "blog/blogNotFound";
		}
	}
	
	@RequestMapping(value = "/post/{userId}/{categoryNo}/{postNo}/{currPage}", method = RequestMethod.GET)
	public String movePost(@PathVariable("userId") String userId ,@PathVariable("categoryNo") Long cno ,
			@PathVariable("postNo") Long pno,@PathVariable("currPage") int currPage, Model model) {
		
		int maxPage = 1;
		int navStartPage = 1;
		int page = currPage;
		
		BlogVo blogVo = blogService.getBlogContent(userId);
		List<CategoryVo> categoryVo = blogService.getCategoryList(userId);

		Map<String, Object> postMap = new HashMap<String, Object>();
		postMap.put("postNo", pno);
		postMap.put("categoryNo", cno);
		postMap.put("userId", userId);
		postMap.put("postPerPage", 3);
		postMap.put("currPage", page);

		List<PostVo> postListVo = blogService.getPostListByPost(postMap); // userId , categortNo , postNo
		maxPage = blogService.getMaxPageCountByPost(3, userId, cno); // postPerPage , userId , categoryNo 

		PostVo postVo = blogService.getPostSelect(postMap);
		
		List<CommentVo> commentVo = blogService.getCommentsPostSelect(postVo.getNo());
		
		navStartPage = (page - 1) / 5 * 5 + 1;

		if (blogVo != null) {
			// 이름이 존재함
			model.addAttribute("blogVo", blogVo);
			model.addAttribute("categoryVo", categoryVo);
			model.addAttribute("postVo", postVo);
			model.addAttribute("userId", userId);
			model.addAttribute("commentVo", commentVo);
			model.addAttribute("postListVo",postListVo);
			
			model.addAttribute("currPage", page);
			model.addAttribute("postPerPage", 3);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("navStartPage", navStartPage);
			model.addAttribute("navPageCount", 5); // 네비게이션 갯수

			return "blog/blogmain";
		} else {
			// 이름이 존재하지 않음.
			return "blog/blogNotFound";
		}
	}
	
	@Auth
	@RequestMapping(value = "/{userId}/deletecomment", method = RequestMethod.POST)
	@ResponseBody
	public Object deleteComment(@PathVariable("userId") String userId, @RequestParam("no") Long no,
			@RequestParam("postNo") Long postNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		Map<String, Object> categoryMap = new HashMap<String, Object>();
		categoryMap.put("no", no);
		categoryMap.put("id", userId);
		categoryMap.put("postNo", postNo);

		boolean result = blogService.deleteComment(categoryMap);

		if(result) {
			map.put("result", "success");
			map.put("data", result);
		}else {
			map.put("result", "fail");
			map.put("data", result);
		}
		
		return map;
	}
	
	@RequestMapping(value = "/post/default/{userId}/{postNo}/{page}", method = RequestMethod.GET)
	public String moveBlogMainDefault(@PathVariable("userId") String userId, @PathVariable("postNo") Long postNo,
			@PathVariable("page") int page,Model model) {

		int maxPage	= 1;
		int navStartPage = 1;
		Map<String, Object> postMap = new HashMap<String, Object>();
		postMap.put("postNo", postNo);
		postMap.put("userId", userId);
		postMap.put("currPage", page);	
		postMap.put("postPerPage", 3);
		
		List<CommentVo> commentVo;
		BlogVo blogVo = blogService.getBlogContent(userId);
		List<CategoryVo> categoryVo = blogService.getCategoryList(userId);
				
		// 전체 페이지수를 가져옴.
		maxPage = blogService.getMaxPageCount(3,userId); // 인자(postPerPage) : 한페이지당 몇개의 게시글을 보여줄지? 
		
		// 페이지에 맞는 게시글을 가져옴.
		List<PostVo> postListVo = blogService.getPostListFirst(postMap);
		
		PostVo postVo = blogService.getPostSelect(postMap);
		
		navStartPage = (page - 1) / 5 * 5 + 1;
		
		if(postVo != null ){
			commentVo = blogService.getComments(postVo.getNo());
			model.addAttribute("commentVo", commentVo);
		}
		if (blogVo != null) {
			// 이름이 존재함
			model.addAttribute("blogVo", blogVo);
			model.addAttribute("categoryVo", categoryVo);
			model.addAttribute("postListVo", postListVo);
			model.addAttribute("postVo", postVo);
			model.addAttribute("userId", userId);
			
			model.addAttribute("currPage", page);
			model.addAttribute("postPerPage", 3);
			model.addAttribute("maxPage", maxPage);
			model.addAttribute("navStartPage", navStartPage);
			model.addAttribute("navPageCount", 5); // 네비게이션 갯수

			return "blog/blogmaindefault";
		} else {
			// 이름이 존재하지 않음.
			return "blog/blogNotFound";
		}
	}
	
	@RequestMapping(value="/search" , method = RequestMethod.GET)
	public String Search(Model model,@RequestParam("search_text") String searchText , 
			@RequestParam("search_radio") String selectRadio) {
		
		List<SearchVo> searchVo = blogService.searchBlogAndBlogger(searchText , selectRadio);
		
		model.addAttribute("searchVo",searchVo);
		return "blog/searchResult";
	}
}



