package com.techblog.entitties;

import java.sql.Timestamp;

public class Comment {

	private Long coid;
	private String comessage;
	private Long pid;
	private Long uid;
	private String uprofile;
	private String uname;
	private Timestamp time;

	public Comment() {
		super();
	}

	public Comment(String comessage, Long pid, String uprofile, String uname, Timestamp time) {
		super();
		this.comessage = comessage;
		this.pid = pid;
		this.uprofile = uprofile;
		this.uname = uname;
		this.time = time;
	}

	public Comment(Long coid, String comessage, Long pid, Long uid, Timestamp time) {
		super();
		this.coid = coid;
		this.comessage = comessage;
		this.pid = pid;
		this.uid = uid;
		this.time = time;
	}

	public Comment(String comessage, Long pid, Long uid, Timestamp time) {
		super();
		this.comessage = comessage;
		this.pid = pid;
		this.uid = uid;
		this.time = time;
	}

	public Comment(Long coid, String comessage, Long pid, Long uid) {
		super();
		this.coid = coid;
		this.comessage = comessage;
		this.pid = pid;
		this.uid = uid;
	}

	public Comment(String comessage, Long pid, Long uid) {
		super();
		this.comessage = comessage;
		this.pid = pid;
		this.uid = uid;
	}

	public Long getCoid() {
		return coid;
	}

	public void setCoid(Long coid) {
		this.coid = coid;
	}

	public String getComessage() {
		return comessage;
	}

	public void setComessage(String comessage) {
		this.comessage = comessage;
	}

	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	public Long getUid() {
		return uid;
	}

	public void setUid(Long uid) {
		this.uid = uid;
	}

	public Timestamp getTime() {
		return time;
	}

	public void setTime(Timestamp time) {
		this.time = time;
	}

	public String getUprofile() {
		return uprofile;
	}

	public void setUprofile(String uprofile) {
		this.uprofile = uprofile;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

}
