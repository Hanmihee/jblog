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

import com.example.jblog.services.BlogService;
import com.example.jblog.vo.BlogVo;
import com.example.jblog.vo.CategoryVo;
import com.example.jblog.vo.CommentVo;
import com.example.jblog.vo.PostVo;

@Controller
@RequestMapping("/blog")
public class BlogController {
	@Autowired
	private BlogService blogService;

	@RequestMapping(value = "/{userId}/admin/basicsetting", method = RequestMethod.GET)
	public String moveBasicSetting() {
		return "blog/basicsetting";
	}

	@RequestMapping(value = "/{userId}/admin/boardwriteform", method = RequestMethod.GET)
	public String moveBoardWrite(Model model, @PathVariable("userId") String userId) {
		List<CategoryVo> categoryVo = blogService.getCategoryList(userId);
		model.addAttribute("categoryVo", categoryVo);
		return "blog/boardwriteform";
	}

	@RequestMapping(value = "/{userId}/admin/categorysetting", method = RequestMethod.GET)
	public String moveCategorySetting(Model model, @PathVariable("userId") String userId) {
		List<CategoryVo> categoryVo = blogService.getCategoryList(userId);
		model.addAttribute("categoryVo", categoryVo);
		return "blog/categorysetting";
	}

	@RequestMapping(value = "/{userId}/admin/boardwrite", method = RequestMethod.POST)
	public String boardWriteAction(@PathVariable("userId") String userId, @ModelAttribute PostVo vo) {
		Map<String, Object> postMap = new HashMap<String, Object>();
		postMap.put("title", vo.getTitle());
		System.out.println("title : " + vo.getTitle());
		postMap.put("content", vo.getContent());
		System.out.println("content : " + vo.getContent());
		postMap.put("categoryNo", vo.getCategoryNo());
		System.out.println("categoryNo : " + vo.getCategoryNo());
		postMap.put("id", userId);

		boolean result = blogService.writePost(postMap);

		if (result) {
			return "redirect:/blog/" + userId + "/admin/boardwriteform";
		} else {
			return "blog/postfail";
		}
	}

	@RequestMapping(value = "/{userId}/admin/getCategoryList", method = RequestMethod.GET)
	@ResponseBody
	public List<CategoryVo> getCategoryList(@PathVariable("userId") String userId) {
		return blogService.getCategoryList(userId);
	}

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
		List<CommentVo> commentVo;
		// TODO : if문 정리하기
		BlogVo blogVo = blogService.getBlogContent(userId);
		List<CategoryVo> categoryVo = blogService.getCategoryList(userId);
		// 모든 게시글을 가져옴.
		List<PostVo> postListVo = blogService.getPostListFirst(userId);
		// 맨위의 글을 가져옴. (최신글)
		PostVo postVo = blogService.getPostNewestFirst(userId);
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

			return "blog/blogmain";
		} else {
			// 이름이 존재하지 않음.
			return "blog/blogNotFound";
		}
	}

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

	@RequestMapping(value = "/{userId}/postList", method = RequestMethod.POST)
	@ResponseBody
	public List<PostVo> getCategoryPostList(@PathVariable("userId") String userId,
			@RequestParam("categoryno") String categoryNo) {
		Map<String, Object> postMap = new HashMap<String, Object>();
		postMap.put("userId", userId);
		postMap.put("categoryNo", categoryNo);

		return blogService.getCategoryPostList(postMap);
	}

	@RequestMapping(value = "/{userId}/post", method = RequestMethod.POST)
	@ResponseBody
	public List<PostVo> getPost(@PathVariable("userId") String userId, @RequestParam("no") String no) {
		Map<String, Object> postMap = new HashMap<String, Object>();
		postMap.put("userId", userId);
		postMap.put("no", no);

		return blogService.getPost(postMap);
	}

	@RequestMapping(value = "{userId}/addcomment", method = RequestMethod.POST)
	@ResponseBody
	public List<CommentVo> getCommentList(@PathVariable("userId") String userId,
			@RequestParam("content") String content, @RequestParam("postno") String postNo) {
		Map<String, Object> commentMap = new HashMap<String, Object>();
		commentMap.put("userId", userId);
		commentMap.put("postNo", postNo);
		commentMap.put("content", content);

		return blogService.getCommentList(commentMap);
	}

	@RequestMapping(value = "{userId}/getComment", method = RequestMethod.POST)
	@ResponseBody
	public List<CommentVo> getCommentList(@PathVariable("userId") String userId, @RequestParam("postno") Long postNo) {

		return blogService.getComments(postNo);
	}

	@RequestMapping(value = "/category/{userId}/{categoryNo}", method = RequestMethod.GET)
	public String moveCategory(@PathVariable("userId") String userId, @PathVariable("categoryNo") Long no,
			Model model) {
		List<CommentVo> commentVo;
		
		BlogVo blogVo = blogService.getBlogContent(userId);
		List<CategoryVo> categoryVo = blogService.getCategoryList(userId);

		Map<String, Object> postMap = new HashMap<String, Object>();
		postMap.put("categoryNo", no);
		postMap.put("userId", userId);

		List<PostVo> postListVo = blogService.getPostList(postMap); // 수정필요
		PostVo postVo = blogService.getPostNewest(postMap); // 수정 필요
		
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

			return "blog/blogmain";
		} else {
			// 이름이 존재하지 않음.
			return "blog/blogNotFound";
		}
	}

	@RequestMapping(value = "/post/{userId}/{categoryNo}/{postNo}", method = RequestMethod.GET)
	public String movePost(@PathVariable("userId") String userId ,@PathVariable("categoryNo") Long cno ,
			@PathVariable("postNo") Long pno, Model model) {
		BlogVo blogVo = blogService.getBlogContent(userId);
		List<CategoryVo> categoryVo = blogService.getCategoryList(userId);

		Map<String, Object> postMap = new HashMap<String, Object>();
		postMap.put("postNo", pno);
		postMap.put("categoryNo", cno);
		postMap.put("userId", userId);

		List<PostVo> postListVo = blogService.getPostList(postMap);

		PostVo postVo = blogService.getPostSelect(postMap);
		List<CommentVo> commentVo = blogService.getCommentsPostSelect(postVo.getNo());

		if (blogVo != null) {
			// 이름이 존재함
			model.addAttribute("blogVo", blogVo);
			model.addAttribute("categoryVo", categoryVo);
			model.addAttribute("postListVo", postListVo);
			model.addAttribute("postVo", postVo);
			model.addAttribute("userId", userId);
			model.addAttribute("commentVo", commentVo);

			return "blog/blogmain";
		} else {
			// 이름이 존재하지 않음.
			return "blog/blogNotFound";
		}
	}
}