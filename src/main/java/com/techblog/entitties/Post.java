package com.techblog.entitties;

import java.sql.Timestamp;

public class Post {

	private Long pid;
	private String ptitle;
	private String pcontent;
	private String pcode;
	private String pimage;
	private Timestamp pdate;
	private Long cid;
	private Long uid;

	public Post() {
		super();
	}

	public Post(String ptitle, String pcontent, String pcode, String pimage, Long cid, Long uid) {
		super();
		this.ptitle = ptitle;
		this.pcontent = pcontent;
		this.pcode = pcode;
		this.pimage = pimage;
		this.cid = cid;
		this.uid = uid;
	}

	public Post(Long pid, String ptitle, String pcontent, String pcode, String pimage, Timestamp pdate, Long cid,
			Long uid) {
		super();
		this.pid = pid;
		this.ptitle = ptitle;
		this.pcontent = pcontent;
		this.pcode = pcode;
		this.pimage = pimage;
		this.pdate = pdate;
		this.cid = cid;
		this.uid = uid;
	}

	public Post(Long pid, String ptitle, String pcontent, String pcode, String pimage, Timestamp pdate, Long uid) {
		super();
		this.pid = pid;
		this.ptitle = ptitle;
		this.pcontent = pcontent;
		this.pcode = pcode;
		this.pimage = pimage;
		this.pdate = pdate;
		this.uid = uid;
	}

	public Post(Long pid, String ptitle, String pcontent) {
		super();
		this.pid = pid;
		this.ptitle = ptitle;
		this.pcontent = pcontent;
	}

	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	public String getPtitle() {
		return ptitle;
	}

	public void setPtitle(String ptitle) {
		this.ptitle = ptitle;
	}

	public String getPcontent() {
		return pcontent;
	}

	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}

	public String getPcode() {
		return pcode;
	}

	public void setPcode(String pcode) {
		this.pcode = pcode;
	}

	public String getPimage() {
		return pimage;
	}

	public void setPimage(String pimage) {
		this.pimage = pimage;
	}

	public Timestamp getPdate() {
		return pdate;
	}

	public void setPdate(Timestamp pdate) {
		this.pdate = pdate;
	}

	public Long getCid() {
		return cid;
	}

	public void setCid(Long cid) {
		this.cid = cid;
	}

	public Long getUid() {
		return uid;
	}

	public void setUid(Long uid) {
		this.uid = uid;
	}

}
