package com.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.VO.BoardsVO;
import com.VO.CommentsVO;
import com.VO.FilesVO;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.service.board.BoardService;
import com.service.board.BoardServiceImpl;
import com.service.board.Paging;
import com.service.comment.CommentService;
import com.service.comment.CommentServiceImpl;

@WebServlet("/BoardController")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private HttpServletRequest request;
	private HttpServletResponse response;
	private String view;
	private PrintWriter out;

	private BoardService boardService = new BoardServiceImpl();
	private CommentService commentService = new CommentServiceImpl();

	public BoardController() {
		super();
	}

	private void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		this.request = request;
		this.response = response;

		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");

		out = response.getWriter();
		String action = request.getParameter("action");

		if (action == null) {
			action = "listBoard";
		}

		switch (action) {

		case "listBoard":
			selectList();
			break;

		case "insert":
			insertBoard();
			selectList();
			break;

		case "boardContents":
			boardContents();
			break;

		case "updateReady":
			updateReady();
			break;

		case "update":
			update();
			boardContents();
			break;

		case "delete":
			delete();
			selectList();
			break;

		case "deleteFile":
			deleteFile();
			break;

		case "search":
			if (!searchList()) {
				selectList();
			}
			break;
		// boardContent 로드 후 댓글 리스트 불러오기 ajax 통신!
		case "selectComment":
			selectComment();
			return;

		case "insertComment":
			insertComment();
			return;

		case "insertSubComment":
			insertSubComment();
			return;

		case "updateComment":
			updateComment();
			return;

		case "deleteComment":
			deleteComment();
			return;

		case "statusComment":
			statusComment();
			return;
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	private void selectComment() {
		int BOARD_CODE = Integer.parseInt(request.getParameter("BOARD_CODE"));
		List<CommentsVO> list = commentService.selectComments(BOARD_CODE);

		JSONArray jArray = new JSONArray();

		for (int i = 0; i < list.size(); i++) {
			JSONObject jsonComment = new JSONObject();

			jsonComment.put("COMMENT_CODE", list.get(i).getCOMMENT_CODE());
			jsonComment.put("BOARD_CODE", list.get(i).getBOARD_CODE());
			jsonComment.put("USER_CODE", list.get(i).getUSER_CODE());
			jsonComment.put("CONTEXT", list.get(i).getCONTEXT());

			jsonComment.put("COUNT_GOOD", list.get(i).getCOUNT_GOOD());
			jsonComment.put("COUNT_BAD", list.get(i).getCOUNT_BAD());
			jsonComment.put("CREATE_DATE", list.get(i).getCREATE_DATE().toString());
			jsonComment.put("UPDATE_DATE", list.get(i).getUPDATE_DATE().toString());

			jsonComment.put("GROUP_NO", list.get(i).getGROUP_NO());
			jsonComment.put("GROUP_ORDER", list.get(i).getGROUP_ORDER());
			jsonComment.put("GROUP_DEPTH", list.get(i).getGROUP_DEPTH());

			jsonComment.put("NAME", list.get(i).getNAME());

			jArray.add(jsonComment);
		}

		out.print(jArray.toString());
		out.flush();
		out.close();
	}

	private void insertComment() {
		if (request.getParameter("CONTEXT") == "")
			return;
		CommentsVO comment = new CommentsVO();

		comment.setBOARD_CODE(Integer.parseInt(request.getParameter("BOARD_CODE")));
		comment.setUSER_CODE(Integer.parseInt(request.getParameter("USER_CODE")));
		comment.setCONTEXT(request.getParameter("CONTEXT"));

		int res = commentService.insertComment(comment);

		if (res > 0) {
			boardService.increaseCountComment(Integer.parseInt(request.getParameter("BOARD_CODE")));
			out.println("true");
			out.close();
		} else {
			out.println("false");
			out.close();
		}
	}

	private void insertSubComment() {
		CommentsVO parentComment = new CommentsVO();
		CommentsVO subComment = new CommentsVO();

		parentComment.setBOARD_CODE(Integer.parseInt(request.getParameter("BOARD_CODE")));
		parentComment.setGROUP_NO(Integer.parseInt(request.getParameter("GROUP_NO")));
		parentComment.setGROUP_ORDER(Integer.parseInt(request.getParameter("GROUP_ORDER")));
		parentComment.setGROUP_DEPTH(Integer.parseInt(request.getParameter("GROUP_DEPTH")));

		subComment.setUSER_CODE(Integer.parseInt(request.getParameter("USER_CODE")));
		subComment.setCONTEXT(request.getParameter("CONTEXT"));

		int res = commentService.insertComment(parentComment, subComment);
		if (res > 0) {
			boardService.increaseCountComment(Integer.parseInt(request.getParameter("BOARD_CODE")));
			out.println("true");
			out.close();
		} else {
			out.println("false");
			out.close();
		}
	}

	private void updateComment() {
		if (request.getParameter("CONTEXT") == "")
			return;
		CommentsVO comment = new CommentsVO();

		comment.setBOARD_CODE(Integer.parseInt(request.getParameter("BOARD_CODE")));
		comment.setCOMMENT_CODE(Integer.parseInt(request.getParameter("COMMENT_CODE")));
		comment.setCONTEXT(request.getParameter("CONTEXT"));

		int res = commentService.updateComment(comment);
		if (res > 0) {
			out.println("true");
			out.close();
		} else {
			out.println("false");
			out.close();
		}
	}

	private void deleteComment() {
		int BOARD_CODE = Integer.parseInt(request.getParameter("BOARD_CODE"));
		System.out.println("delete Comment");

		if (commentService.deleteComment(Integer.parseInt(request.getParameter("COMMENT_CODE")),
				Integer.parseInt(request.getParameter("GROUP_DEPTH")),
				Integer.parseInt(request.getParameter("GROUP_NO")))) {
			boardService.decreaseCountComment(BOARD_CODE);
			out.println("true");
			out.close();
		} else {
			out.println("false");
			out.close();
		}

	}

	private void statusComment() {
		String status = request.getParameter("status");

		int res = 0;
		if (status.equals("good"))
			res = commentService.goodComment(Integer.parseInt(request.getParameter("COMMENT_CODE")));
		if (status.equals("bad"))
			res = commentService.badComment(Integer.parseInt(request.getParameter("COMMENT_CODE")));
		out.println(res);
		out.close();
	}

	// 게시글 리스트
	private void selectList() throws IOException {
		if (request.getParameter("condition") != null && request.getParameter("condition") != "") {
			System.out.println(request.getParameter("condition"));
			System.out.println(request.getParameter("option"));
			System.out.println("검색 변수가 존재해요");
			searchList();
			return;
		}
		Paging paging = new Paging();
		paging.makeLastPageNum();

		int curPage = 1; // 현재 페이지
		if (request.getParameter("curPage") != null) {
			curPage = Integer.parseInt(request.getParameter("curPage"));
			paging.makeBlock(curPage);
			request.setAttribute("curPageNum", curPage);
		} else {
			paging.makeBlock(curPage);
			request.setAttribute("curPageNum", curPage);
		}

		Integer blockStartNum = paging.getBlockStartNum();
		Integer blockLastNum = paging.getBlockLastNum();
		Integer lastPageNum = paging.getLastPageNum();

		request.setAttribute("blockStartNum", blockStartNum);
		request.setAttribute("blockLastNum", blockLastNum);
		request.setAttribute("lastPageNum", lastPageNum);

		request.setAttribute("boardList", boardService.selectBoardsListData(curPage));

		view = "/Board/boardList.jsp";
	}

	private boolean searchList() {
		String option = null;
		String condition = null;

		if (request.getParameter("condition") == "") {
			request.removeAttribute("option");
			request.removeAttribute("condition");
			System.out.println("검색어가 없어요");
			return false;
		} else {
			option = request.getParameter("option");
			condition = request.getParameter("condition");

			Paging paging = new Paging();
			paging.makeLastPageNum(Integer.parseInt(option), condition);

			int curPage = 1; // 현재 페이지
			if (request.getParameter("curPage") != null) {
				curPage = Integer.parseInt(request.getParameter("curPage"));
				paging.makeBlock(curPage);
				request.setAttribute("curPageNum", curPage);
			} else {
				paging.makeBlock(curPage);
				request.setAttribute("curPageNum", curPage);
			}

			Integer blockStartNum = paging.getBlockStartNum();
			Integer blockLastNum = paging.getBlockLastNum();
			Integer lastPageNum = paging.getLastPageNum();

			request.setAttribute("blockStartNum", blockStartNum);
			request.setAttribute("blockLastNum", blockLastNum);
			request.setAttribute("lastPageNum", lastPageNum);

			request.setAttribute("option", option);
			request.setAttribute("condition", condition);

			request.setAttribute("boardList",
					boardService.selectSearchListData(curPage, Integer.parseInt(option), condition));

			view = "/Board/boardList.jsp";

			System.out.println("search 성공!!");
			return true;
		}
	}

	// 게시글 등록
	private void insertBoard() {

		// 업로드될 경로
		String filePath = "/File/Upload/";

		// 업로드될 실제 경로 (이클립스 상의 절대경로)
		String FILE_PATH = request.getSession().getServletContext().getRealPath(filePath);
		System.out.println("절대경로 : " + FILE_PATH);

		String encoding = "UTF-8";
		int maxSize = 1024 * 1024 * 5;

		MultipartRequest mr = null;

		try {

			mr = new MultipartRequest(request, FILE_PATH, // 파일이 저장될 폴더
					maxSize, // 최대 업로드크기 (5MB)
					encoding, // 인코딩 방식
					new DefaultFileRenamePolicy() // 동일한 파일명이 존재하면 파일명 뒤에 일련번호를 부여
			);

		} catch (IOException e1) {
			System.out.println("[ ERROR ] : BoardController - MultipartRequest 객체 생성 오류");
			e1.printStackTrace();
		}

		// 게시글 등록
		BoardsVO insertBoard = new BoardsVO();

		insertBoard.setUSER_CODE(Integer.parseInt(request.getParameter("USER_CODE")));
		insertBoard.setTITLE(mr.getParameter("TITLE"));
		insertBoard.setCONTEXT(mr.getParameter("CONTEXT"));

		if (boardService.insertBoard(insertBoard)) {
			System.out.println("게시물 insert 성공!");
		} else {
			System.out.println("[ ERROR ] : BoardController - insertBoard() 게시물 등록 오류");
		}

		// 파일 첨부
		// Enumeration<?> files = mr.getFileNames(); // 다중파일일 경우

		String FILE_ORIGINAL_NAME = null, FILE_STORED_NAME = null, FILE_SIZE = null;
		String fileType = null;
		String fileExtend = null;

		// while (files.hasMoreElements()) {
		// String parameter = (String) files.nextElement();

		// 실제 저장된 파일명
		FILE_STORED_NAME = mr.getFilesystemName("FILE");

		if (FILE_STORED_NAME != null) {

			// 원래 파일명
			FILE_ORIGINAL_NAME = mr.getOriginalFileName("FILE");

			// 파일 크기
			FILE_SIZE = String.valueOf(mr.getFile("FILE").length());

			// 파일 타입
			fileType = mr.getContentType("FILE");

			// 파일 확장자
			fileExtend = FILE_STORED_NAME.substring(FILE_STORED_NAME.lastIndexOf(".") + 1);
		}
		// }

		FilesVO insertFile = new FilesVO();

		if (FILE_STORED_NAME != null) {

			insertFile.setUSER_CODE(Integer.parseInt(request.getParameter("USER_CODE")));
			insertFile.setFILE_ORIGINAL_NAME(FILE_ORIGINAL_NAME);
			insertFile.setFILE_STORED_NAME(FILE_STORED_NAME);
			insertFile.setFILE_PATH(FILE_PATH);
			insertFile.setFILE_SIZE(FILE_SIZE);

			if (boardService.insertFile(insertFile)) {
				System.out.println(insertFile.toString() + "\n파일타입 : " + fileType + " 파일확장자명 : " + fileExtend);
			} else {
				System.out.println("[ ERROR ] : BoardController - insertBoard() 파일업로드 오류");
			}
		} else {
			insertFile.setUSER_CODE(Integer.parseInt(request.getParameter("USER_CODE")));
			insertFile.setFILE_ORIGINAL_NAME("");
			insertFile.setFILE_STORED_NAME("");
			insertFile.setFILE_PATH("");
			insertFile.setFILE_SIZE("");

			if (boardService.insertFile(insertFile)) {
				System.out.println(insertFile.toString() + "\n파일타입 : " + fileType + " 파일확장자명 : " + fileExtend);
			} else {
				System.out.println("[ ERROR ] : BoardController - insertBoard() 파일업로드 오류");
			}
		}

	}

	// 글 내용
	private void boardContents() {

		// 게시글 내용
		int BOARD_CODE = Integer.parseInt(request.getParameter("BOARD_CODE"));

		boardService.increaseCountView(BOARD_CODE);

		request.setAttribute("boardContents", boardService.selectBoardContents(BOARD_CODE).get("boardsVO"));
		request.setAttribute("userContents", boardService.selectBoardContents(BOARD_CODE).get("usersVO"));
		request.setAttribute("commentsList", commentService.selectComments(BOARD_CODE));

		// 첨부파일 내용
		request.setAttribute("fileContents", boardService.selectFileContents(BOARD_CODE));

		view = "/Board/boardContents.jsp";
	}

	private void updateReady() {
		int BOARD_CODE = Integer.parseInt(request.getParameter("BOARD_CODE"));

		request.setAttribute("boardContents", boardService.selectBoardContents(BOARD_CODE).get("boardsVO"));
		request.setAttribute("fileContents", boardService.selectFileContents(BOARD_CODE));
		System.out.println("updateReady()의 BOARD_CODE : " + boardService.selectFileContents(BOARD_CODE));
		view = "/Board/updateBoard.jsp";
	}

	// 게시글 수정
	private void update() {

		// 업로드될 경로
		String filePath = "/File/Upload/";

		// 업로드될 실제 경로 (이클립스 상의 절대경로)
		String FILE_PATH = request.getSession().getServletContext().getRealPath(filePath);
		System.out.println("절대경로 : " + FILE_PATH);

		String encoding = "UTF-8";
		int maxSize = 1024 * 1024 * 5;

		MultipartRequest mr = null;

		try {

			mr = new MultipartRequest(request, FILE_PATH, // 파일이 저장될 폴더
					maxSize, // 최대 업로드크기 (5MB)
					encoding, // 인코딩 방식
					new DefaultFileRenamePolicy() // 동일한 파일명이 존재하면 파일명 뒤에 일련번호를 부여
			);

		} catch (IOException e1) {
			System.out.println("[ ERROR ] : BoardController - MultipartRequest 객체 생성 오류");
			e1.printStackTrace();
		}

		// 게시글 수정
		BoardsVO updateBoard = new BoardsVO();

		updateBoard.setTITLE(request.getParameter("TITLE"));
		updateBoard.setCONTEXT(request.getParameter("CONTEXT"));
		updateBoard.setBOARD_CODE(Integer.parseInt(request.getParameter("BOARD_CODE")));

		if (boardService.updateBoard(updateBoard)) {
			System.out.println("게시물 수정 성공!");
		} else {
			System.out.println("[ ERROR ] : BoardController - update() 게시물 수정 오류");
		}

		// 파일 첨부
		// Enumeration<?> files = mr.getFileNames(); // 다중파일일 경우

		String FILE_ORIGINAL_NAME = null, FILE_STORED_NAME = null, FILE_SIZE = null;
		String fileType = null;
		String fileExtend = null;

		// while (files.hasMoreElements()) {
		// String parameter = (String) files.nextElement();

		// 실제 저장된 파일명
		FILE_STORED_NAME = mr.getFilesystemName("FILE");

		if (FILE_STORED_NAME != null) {

			// 원래 파일명
			FILE_ORIGINAL_NAME = mr.getOriginalFileName("FILE");

			// 파일 크기
			FILE_SIZE = String.valueOf(mr.getFile("FILE").length());

			// 파일 타입
			fileType = mr.getContentType("FILE");

			// 파일 확장자
			fileExtend = FILE_STORED_NAME.substring(FILE_STORED_NAME.lastIndexOf(".") + 1);
		}
		// }

		FilesVO updateFile = new FilesVO();

		if (FILE_STORED_NAME != null) {

			updateFile.setFILE_CODE(Integer.parseInt(request.getParameter("FILE_CODE")));
			updateFile.setFILE_ORIGINAL_NAME(FILE_ORIGINAL_NAME);
			updateFile.setFILE_STORED_NAME(FILE_STORED_NAME);
			updateFile.setFILE_PATH(FILE_PATH);
			updateFile.setFILE_SIZE(FILE_SIZE);

			if (boardService.updateFile(updateFile)) {
				System.out.println(updateFile.toString() + "\n파일타입 : " + fileType + " 파일확장자명 : " + fileExtend);
			} else {
				System.out.println("[ ERROR ] : BoardController - updateBoard() 파일업로드 오류");
			}
		}
	}

	// 게시글 수정 시 업로드된 파일 삭제
	private void deleteFile() {
		int FILE_CODE = Integer.parseInt(request.getParameter("FILE_CODE"));
		int BOARD_CODE = Integer.parseInt(request.getParameter("BOARD_CODE"));

		String FILE_STORED_NAME = boardService.selectFileContents(BOARD_CODE).getFILE_STORED_NAME();
		System.out.println("deleteFile()의 FILE_STORED_NAME : " + FILE_STORED_NAME);

		if (boardService.deleteFile(FILE_CODE)) {
			System.out.println("첨부파일 delete 성공!");

			// 서버경로에서 물리적으로 파일 삭제
			String filePath = "/File/Upload/";
			String FILE_PATH = request.getSession().getServletContext().getRealPath(filePath) + FILE_STORED_NAME;

			File file = new File(FILE_PATH);
			System.out.println("삭제할 file : " + file);

			if (file.exists()) {
				if (file.delete()) {
					System.out.println("서버에서 물리적으로 파일삭제 성공!");
				} else {
					System.out.println("서버에서 물리적으로 파일삭제 실패");
				}
			} else {
				System.out.println("파일이 존재하지 않음");
			}

			view = "/BoardController?action=updateReady&BOARD_CODE=" + BOARD_CODE;
		} else {
			System.out.println("[ ERROR ] : BoardController - deleteFile() 첨부파일 삭제 오류");
		}
	}

	private void delete() {

		if (boardService.deleteBoard(Integer.parseInt(request.getParameter("BOARD_CODE")))) {
			System.out.println("게시물 delete 성공!");
		} else {
			System.out.println("[ ERROR ] : BoardController - delete() 게시물 삭제 오류");
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response);
	}

}