package com.example.jblog.services;

import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Calendar;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class FileUploadService {
	private static String SAVE_PATH = "/logo";

	public String updateSetting(MultipartFile logoImg) {
		String saveFilename = "";

		try {
			System.out.println("들어옴?1");
			String originalFilename = logoImg.getOriginalFilename(); // 원본 파일명
			String extName = originalFilename.substring(originalFilename.lastIndexOf("."), originalFilename.length());
			Long size = logoImg.getSize();

			saveFilename = getSaveFilename(extName);

			writeFile(logoImg, saveFilename);
		} catch (IOException e) {
			throw new RuntimeException(e.getMessage());
		}
//		System.out.println("들어옴?2 : "+saveFilename);
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
}
