package com.rhizome.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="sop_checklist")
public class SOPCheckList {
	@Id
	@Column(name = "sop_checklist_id")
	@GeneratedValue
	private long sopCheckListId;

	public long getSopCheckListId() {
		return sopCheckListId;
	}

	public void setSopCheckListId(long sopCheckListId) {
		this.sopCheckListId = sopCheckListId;
	}
	
	@Column(name = "group_id")
	private long groupId;
	
	public long getGroupId() {
		return groupId;
	}

	public void setGroupId(long groupId) {
		this.groupId = groupId;
	}
	
	@Column(name = "company_id")
	private long companyId;
	
	public long getCompanyId() {
		return companyId;
	}

	public void setCompanyId(long companyId) {
		this.companyId = companyId;
	}
	
	@Column(name = "user_id")
	private long userId;
	
	public long getUserId() {
		return userId;
	}

	public void setUserId(long userId) {
		this.userId = userId;
	}
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "created_date")
	private Date createdDate;
	
	public Date getCreatedDate() {
		return createdDate;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "modified_date")
	private Date modifiedDate;
	
	public Date getModifiedDate() {
		return modifiedDate;
	}

	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	
	@Column(name = "sop_article_id")
	private long sopArticleId;

	public long getSopArticleId() {
		return sopArticleId;
	}

	public void setSopArticleId(long sopArticleId) {
		this.sopArticleId = sopArticleId;
	}
	
	@Column(name = "checked")
	private boolean checked;

	public boolean isChecked() {
		return checked;
	}

	public void setChecked(boolean checked) {
		this.checked = checked;
	}
}
