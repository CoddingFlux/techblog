package com.techblog.entitties;

import java.security.Timestamp;

public class CommentReply {

	private Long rpcoid;
	private Long uid;
	private Long pid;
	private Long coid;
	private Timestamp rptime;
	
	public CommentReply() {
		super();
	}

	public CommentReply(Long rpcoid, Long uid, Long pid, Long coid, Timestamp rptime) {
		super();
		this.rpcoid = rpcoid;
		this.uid = uid;
		this.pid = pid;
		this.coid = coid;
		this.rptime = rptime;
	}

	public CommentReply(Long rpcoid, Long uid, Long pid, Long coid) {
		super();
		this.rpcoid = rpcoid;
		this.uid = uid;
		this.pid = pid;
		this.coid = coid;
	}

	public CommentReply(Long uid, Long pid, Long coid) {
		super();
		this.uid = uid;
		this.pid = pid;
		this.coid = coid;
	}

	public Long getRpcoid() {
		return rpcoid;
	}

	public void setRpcoid(Long rpcoid) {
		this.rpcoid = rpcoid;
	}

	public Long getUid() {
		return uid;
	}

	public void setUid(Long uid) {
		this.uid = uid;
	}

	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	public Long getCoid() {
		return coid;
	}

	public void setCoid(Long coid) {
		this.coid = coid;
	}

	public Timestamp getRptime() {
		return rptime;
	}

	public void setRptime(Timestamp rptime) {
		this.rptime = rptime;
	}
	
	
	
	
	
}
