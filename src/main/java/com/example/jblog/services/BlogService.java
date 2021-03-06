package com.example.jblog.services;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.jblog.repositories.BlogDao;
import com.example.jblog.vo.BlogVo;
import com.example.jblog.vo.CategoryVo;
import com.example.jblog.vo.CommentVo;
import com.example.jblog.vo.PostVo;
import com.example.jblog.vo.SearchVo;

@Service
public class BlogService {

	@Autowired
	private BlogDao blogDao;

	public BlogVo getBlogContent(String userId) {
		return blogDao.getBlogById(userId);
	}

	public boolean updateBlogNameAndLogo(Map<String , String> blogMap) {
		return blogDao.saveBlogNameAndLogo(blogMap);
	}
	
	private static String SAVE_PATH = "/logo";

	public String updateSetting(MultipartFile logoImg) {
		String saveFilename = "";

		try {
			String originalFilename = logoImg.getOriginalFilename(); // 원본 파일명
			String extName = originalFilename.substring(originalFilename.lastIndexOf("."), originalFilename.length());
			Long size = logoImg.getSize();

			saveFilename = getSaveFilename(extName);

			writeFile(logoImg, saveFilename);
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		}
		return saveFilename;
	}

	public String getSaveFilename(String extName) {
		Calendar cal = Calendar.getInstance();
		String newFilename = String.valueOf(cal.getTimeInMillis() / 1000) + extName.toString();

		return newFilename;
	}

	private void writeFile(MultipartFile mFile, String saveFilename) throws IOException {
		byte[] fileData = mFile.getBytes(); // 이미지를 가져옴

		FileOutputStream fos = new FileOutputStream(SAVE_PATH + "/" + saveFilename);

		fos.write(fileData); // 이미지를 upload 폴더에 넣어줌
		fos.close();
	}

	public boolean addCategory(Map<String, Object> categoryMap) {
		return blogDao.insertCategory(categoryMap);
	}

	public boolean deleteCategory(Map<String, Object> categoryMap) {
		return blogDao.deleteCategory(categoryMap);
	}

	public List<CategoryVo> getCategoryList(String userId) {
		return blogDao.selectCategory(userId);
	}

	public boolean writePost(Map<String, Object> postMap) {
		return blogDao.insertPost(postMap);
	}

	public PostVo getPostNewest(Map<String, Object> postMap) {
		return blogDao.selectOnePost(postMap);
	}

	public List<PostVo> getCategoryPostList(Map<String, Object> postMap) {
		return blogDao.selectCategoryPostList(postMap);
	}

	public List<PostVo> getPost(Map<String, Object> postMap) {
		return blogDao.selectPost(postMap);
	}

	public List<CommentVo> getCommentList(Map<String, Object> commentMap) {
		return blogDao.selectCommentList(commentMap);
	}

	public List<CommentVo> getComments(Long postNo) {
		return blogDao.getComments(postNo);
	}

	public List<PostVo> getPostListFirst(Map<String,Object> postMap){
		return blogDao.getPostListFirst(postMap);
	}
	
	public PostVo getPostNewestFirst(String userId) {
		return blogDao.getPostNewwstFirst(userId);
	}

	public PostVo getPostSelect(Map<String, Object> postMap) {
		return blogDao.getPostSelect(postMap);
	}

	public List<CommentVo> getCommentsPostSelect(Long no) {
		return blogDao.getCommentsPostSelect(no);
	}

	public boolean deleteComment(Map<String, Object> categoryMap) {
		return blogDao.deleteComment(categoryMap);
	}

	public int getMaxPageCount(int postPerPage,String userId) {
		return blogDao.getMaxPageCount(postPerPage,userId);
	}
	
	public List<PostVo> getPostListCategory(Map<String, Object> postMap) {
		return blogDao.getPostListCategory(postMap);
	}

	public int getMaxPageCountCategory(int postPerPage, String userId, Long categoryNo) {
		return blogDao.getMaxPageCountCategory(postPerPage , userId , categoryNo);
	}

	public List<PostVo> getPostListByPost(Map<String, Object> postMap) {
		return blogDao.getPostListByPost(postMap);
	}

	public int getMaxPageCountByPost(int postPerPage, String userId, Long categoryNo) {
		return blogDao.getMaxPageCountByPost(postPerPage,userId,categoryNo);
	}

	public List<SearchVo> searchBlogAndBlogger(String searchText, String selectRadio) {
		return blogDao.getBlogNameAndBlogger(searchText,selectRadio);
	}
}