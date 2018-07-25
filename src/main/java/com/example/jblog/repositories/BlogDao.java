package com.example.jblog.repositories;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.jblog.vo.BlogVo;
import com.example.jblog.vo.CategoryVo;
import com.example.jblog.vo.CommentVo;
import com.example.jblog.vo.PagingVo;
import com.example.jblog.vo.PostVo;

@Repository
public class BlogDao {
	@Autowired
	private SqlSession sqlSession;

	public BlogVo getBlogById(String userId) {
		return sqlSession.selectOne("blog.selectBlogById", userId);
	}

	public boolean saveBlogNameAndLogo(Map<String, String> blogMap) {
		int count;

		if (blogMap.get("logo") == null) {
			count = sqlSession.update("blog.updateBlogName", blogMap);
		} else if (blogMap.get("title") == null) {
			count = sqlSession.update("blog.updateBlogLogo", blogMap);
		} else {
			count = sqlSession.update("blog.updateBlogNameAndLogo", blogMap);
		}
		return count == 1;
	}

	public boolean insertCategory(Map<String, Object> categoryMap) {
		int count = sqlSession.insert("category.insertCategory", categoryMap);
		return count == 1;
	}

	public boolean deleteCategory(Map<String, Object> categoryMap) {
		int count = sqlSession.delete("category.deleteCategory", categoryMap);
		return count == 1;
	}

	public List<CategoryVo> selectCategory(String userId) {
		return sqlSession.selectList("category.selectCategory", userId);
	}

	public boolean insertPost(Map<String, Object> postMap) {
		int count = sqlSession.insert("post.insertPost", postMap);
		return count == 1;
	}

	public PostVo selectOnePost(Map<String, Object> postMap) {
		return sqlSession.selectOne("post.selectPostOne", postMap);
	}

	public List<PostVo> selectCategoryPostList(Map<String, Object> postMap) {
		return sqlSession.selectList("post.selectCategoryPost", postMap);
	}

	public List<PostVo> selectPost(Map<String, Object> postMap) {
		return sqlSession.selectList("post.selectPost", postMap);
	}

	public List<CommentVo> selectCommentList(Map<String, Object> commentMap) {
		int count = sqlSession.insert("comment.insertComment", commentMap);

		return sqlSession.selectList("comment.selectCommentList", commentMap);
	}

	public List<CommentVo> getComments(Long postNo) {
		return sqlSession.selectList("comment.selectCommentList", postNo);
	}

	/* 페이지의 게시글들 모두 가져오기 */
	public List<PostVo> getPostListFirst(Map<String, Object> postMap) {
		// 한페이지 데이터 가져오기
		Map<String, Object> postListMap = new HashMap<String, Object>();
		int currPage = (Integer) postMap.get("currPage");
		int postPerPage = (Integer) postMap.get("postPerPage");
		int startPos = (currPage - 1) * postPerPage;

		postListMap.put("startPos", startPos);
		postListMap.put("postPerPage", postMap.get("postPerPage"));
		postListMap.put("userId", postMap.get("userId"));
		return sqlSession.selectList("post.selectPostListFirst", postListMap);
	}

	public PostVo getPostNewwstFirst(String userId) {
		return sqlSession.selectOne("post.selectPostOneFirst", userId);
	}

	public PostVo getPostSelect(Map<String, Object> postMap) {
		return sqlSession.selectOne("post.selectPostSelect", postMap);
	}

	public List<CommentVo> getCommentsPostSelect(Long postNo) {
		return sqlSession.selectList("comment.selectCommentList", postNo);
	}

	public boolean deleteComment(Map<String, Object> categoryMap) {
		int count = sqlSession.delete("comment.deleteComment", categoryMap);
		return count == 1;
	}

	public int getMaxPageCount(int postPerPage, String userId) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("postPerPage", postPerPage);

		PagingVo vo = sqlSession.selectOne("post.selectMaxPageCount", map);
		int div = vo.getPdiv();
		int mod = vo.getPmod();

		int maxPage = div;

		if (mod > 0) {
			maxPage += 1;
		}

		return maxPage;
	}

	public List<PostVo> getPostListCategory(Map<String, Object> postMap) {
		Map<String, Object> postListMap = new HashMap<String, Object>();
		int currPage = (Integer) postMap.get("currPage");
		int postPerPage = (Integer) postMap.get("postPerPage");
		int startPos = (currPage - 1) * postPerPage;

		postListMap.put("categoryNo", postMap.get("categoryNo"));
		postListMap.put("startPos", startPos);
		postListMap.put("postPerPage", postMap.get("postPerPage"));
		postListMap.put("userId", postMap.get("userId"));

		return sqlSession.selectList("post.selectPostListCategory", postListMap);
	}

	public int getMaxPageCountCategory(int postPerPage, String userId, Long categoryNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("postPerPage", postPerPage);
		map.put("categoryNo", categoryNo);

		PagingVo vo = sqlSession.selectOne("post.selectMaxPageCountCategory", map);
		int div = vo.getPdiv();
		int mod = vo.getPmod();

		int maxPage = div;

		if (mod > 0) {
			maxPage += 1;
		}

		return maxPage;
	}

	public List<PostVo> getPostListByPost(Map<String, Object> postMap) {
		Map<String, Object> postListMap = new HashMap<String, Object>();
		int currPage = (Integer) postMap.get("currPage");
		int postPerPage = (Integer) postMap.get("postPerPage");
		int startPos = (currPage - 1) * postPerPage;

		postListMap.put("categoryNo", postMap.get("categoryNo"));
		postListMap.put("startPos", startPos);
		postListMap.put("postPerPage", postMap.get("postPerPage"));
		postListMap.put("userId", postMap.get("userId"));

		return sqlSession.selectList("post.selectPostListCategory", postListMap);
	}

	public int getMaxPageCountByPost(int postPerPage, String userId, Long categoryNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("postPerPage", postPerPage);
		map.put("categoryNo", categoryNo);

		PagingVo vo = sqlSession.selectOne("post.selectMaxPageCountCategory", map);
		int div = vo.getPdiv();
		int mod = vo.getPmod();

		int maxPage = div;

		if (mod > 0) {
			maxPage += 1;
		}

		return maxPage;
	}
}