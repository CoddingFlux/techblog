package com.techblog.entitties;

public class CustomProperty {

	private String content;
	private String contentType;
	private String cssClass;

	public CustomProperty() {
	}

	public CustomProperty(String content, String contentType, String cssClass) {
		super();
		this.content = content;
		this.contentType = contentType;
		this.cssClass = cssClass;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getContentType() {
		return contentType;
	}

	public void setContentType(String contentType) {
		this.contentType = contentType;
	}

	public String getCssClass() {
		return cssClass;
	}

	public void setCssClass(String cssClass) {
		this.cssClass = cssClass;
	}

}
