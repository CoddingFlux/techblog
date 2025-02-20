package com.techblog.entitties;

public class Categories {

	private Long cid;
	private String cname;
	private String cdescription;
	
	
	public Categories() {
		super();
	}


	public Categories(String cname, String cdescription) {
		super();
		this.cname = cname;
		this.cdescription = cdescription;
	}


	public Categories(Long cid, String cname, String cdescription) {
		super();
		this.cid = cid;
		this.cname = cname;
		this.cdescription = cdescription;
	}


	public Long getCid() {
		return cid;
	}


	public void setCid(Long cid) {
		this.cid = cid;
	}


	public String getCname() {
		return cname;
	}


	public void setCname(String cname) {
		this.cname = cname;
	}


	public String getCdescription() {
		return cdescription;
	}


	public void setCdescription(String cdescription) {
		this.cdescription = cdescription;
	}
	
	
	
	
	
	
}
