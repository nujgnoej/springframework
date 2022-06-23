package com.spring.javagreenS.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javagreenS.dao.BoardDAO;
import com.spring.javagreenS.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;

	@Override
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize) {
		return boardDAO.getBoardList(startIndexNo, pageSize);
	}

	@Override
	public void imgCheck(String content) {
		//      1         2         3         4         5         6
		//      012345678901234567890123456789012345678901234567890123456789012345678901234567890
		// <img src="/javagreenS/data/ckeditor/220622152246_map.jpg" style="height:838px; width:1489px" /></p>
		
		// 이 작업은 content안에 그림파일(img src="/)가 있을때만 수행한다.
		if(content.indexOf("src=\"/") == -1) return;
		
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
		
		int position = 31;
		String nextImg = content.substring(content.indexOf("src=\"/") + position);
		boolean sw = true;
		
		while(sw) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
			
			String oriFilePath = uploadPath + imgFile;
			String copyFilePath = uploadPath + "board/" + imgFile;
			
			fileCopyCheck(oriFilePath, copyFilePath);	// board폴더에 파일을 복사처리한다.
			
			if(nextImg.indexOf("src=\"/") == -1) {
				sw = false;
			}
			else {
				nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
			}
		}
	}
	
	// 실제 서버(ckeditor)에 저장되어 있는 파일을 board폴더로 복사처리한다.
	private void fileCopyCheck(String oriFilePath, String copyFilePath) {
		File oriFile = new File(oriFilePath);
		File copyFile = new File(copyFilePath);
		
		try {
			FileInputStream fis = new FileInputStream(oriFile);
			FileOutputStream fos = new FileOutputStream(copyFile);
			
			byte[] buffer = new byte[2048];
			int count = 0;
			while((count = fis.read(buffer)) != -1) {
				fos.write(buffer, 0, count);
			}
			fos.flush();
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void setBoardInput(BoardVO vo) {
		boardDAO.setBoardInput(vo);
	}

	@Override
	public void setReadNum(int idx) {
		boardDAO.setReadNum(idx);
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public List<BoardVO> getBoardSearch(int startIndexNo, int pageSize, String search, String searchString) {
		return boardDAO.getBoardSearch(startIndexNo, pageSize, search, searchString);
	}

	@Override
	public ArrayList<BoardVO> getPreNext(int idx) {
		return boardDAO.getPreNext(idx);
	}

	@Override
	public int getMinIdx() {
		return boardDAO.getMinIdx();
	}
}
