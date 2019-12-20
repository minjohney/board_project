package com.spring.board.form;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class BoardForm extends CommonForm {

	List<MultipartFile> files;
	int b_num;
	String b_writer;
	String b_title;
	String b_content;
	int b_count;
	String del_yn;
	String b_id;
	String b_date;
	String b_uid;
	String b_udate;
	String search_type;
	String board_file;
	String delete_file;
	public List<MultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}
	public int getB_num() {
		return b_num;
	}
	public void setB_num(int b_num) {
		this.b_num = b_num;
	}
	public String getB_writer() {
		return b_writer;
	}
	public void setB_writer(String b_writer) {
		this.b_writer = b_writer;
	}
	public String getB_title() {
		return b_title;
	}
	public void setB_title(String b_title) {
		this.b_title = b_title;
	}
	public String getB_content() {
		return b_content;
	}
	public void setB_content(String b_content) {
		this.b_content = b_content;
	}
	public int getB_count() {
		return b_count;
	}
	public void setB_count(int b_count) {
		this.b_count = b_count;
	}
	public String getDel_yn() {
		return del_yn;
	}
	public void setDel_yn(String del_yn) {
		this.del_yn = del_yn;
	}
	public String getB_id() {
		return b_id;
	}
	public void setB_id(String b_id) {
		this.b_id = b_id;
	}
	public String getB_date() {
		return b_date;
	}
	public void setB_date(String b_date) {
		this.b_date = b_date;
	}
	public String getB_uid() {
		return b_uid;
	}
	public void setB_uid(String b_uid) {
		this.b_uid = b_uid;
	}
	public String getB_udate() {
		return b_udate;
	}
	public void setB_udate(String b_udate) {
		this.b_udate = b_udate;
	}
	public String getSearch_type() {
		return search_type;
	}
	public void setSearch_type(String search_type) {
		this.search_type = search_type;
	}
	public String getBoard_file() {
		return board_file;
	}
	public void setBoard_file(String board_file) {
		this.board_file = board_file;
	}
	public String getDelete_file() {
		return delete_file;
	}
	public void setDelete_file(String delete_file) {
		this.delete_file = delete_file;
	}
	
	

	
}
