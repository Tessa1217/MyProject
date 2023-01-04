package egovframework.fusion.board;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.annotation.Resource;

import org.junit.Test;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.geometry.Positions;
import net.coobird.thumbnailator.name.Rename;

public class BoardTest {
	
/*	@Test
	public void dateTest() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy\\MM\\dd");
		Date date = new Date();
		System.out.println(sdf.format(date));
		String str = sdf.format(date);
		System.out.println(str);
		str.replaceAll("\\", "/");
		System.out.println(str);
		System.out.println("바뀐 거: " + sdf.format(date).replaceAll("\\", "/"));
		
	}*/
	
	@Resource(name="uploadPath")
	private String uploadPath;
	
/*	@Test*/
	public void makeThumbnail() {
		File thumbnailFile = new File("/images/no-image-icon-23485.png");
		File destinationDir = new File("C:\\");
		destinationDir.getParentFile().mkdirs();
		
		try {
			Thumbnails.of(thumbnailFile)
				.sourceRegion(Positions.CENTER, 300, 200)
				.size(300, 200)
				.toFiles(destinationDir, Rename.NO_CHANGE);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
/*	@Test*/
	public void parseString() {
		String date = "2022-12-20";
		String hour = "8:00";
		String fullDate = date + " " + hour;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date dateParsed = null;
		try {
			dateParsed = format.parse(fullDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		System.out.println(dateParsed.before(new Date()));
		System.out.println(dateParsed);
	}
	
/*	@Test*/
	public void dateCompare() {
		String date1 = "2022-12-20";
		Date date2 = new Date();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date date3 = null;
		try {
			date3 = format.parse(date1);
			System.out.println(date2.getTime() == date3.getTime());
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (date2.compareTo(date3) == 0) {
			System.out.println("True");
		} else {
			System.out.println("False");
		}
	}
	
	@Test
	public void dateComparison() {
		String day1 = "2022-12-20";
		String time1 = "10:00";
		String time2 = "11:00";
		String time3 = "22:00";
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		try {
			Date date1 = format.parse(day1 + " " + time1);
			Date date2 = format.parse(day1 + " " + time2);
			Date date3 = format.parse(day1 + " " + time3);
			System.out.println(date2.after(date1));
			System.out.println(date2.before(date3));
		} catch (Exception e) {
			System.out.println("에러");
		}
	}
	

}
