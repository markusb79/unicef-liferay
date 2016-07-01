package com.rhizome.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="solution_comment_like")
public class SolutionCommentLike {
	@Id
	@Column(name = "solution_comment_like_id")
	@GeneratedValue
	private long commentLikeId;

	public long getCommentLikeId() {
		return commentLikeId;
	}

	public void setCommentLikeId(long commentLikeId) {
		this.commentLikeId = commentLikeId;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "solution_id", nullable = false)
	private Solution solution;
	
	public Solution getSolution() {
		return solution;
	}

	public void setSolution(Solution solution) {
		this.solution = solution;
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
	@Column(name = "liked_date")
	private Date likedDate;

	public Date getLikedDate() {
		return likedDate;
	}

	public void setLikedDate(Date likedDate) {
		this.likedDate = likedDate;
	}
	
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "solution_comment_id", nullable = false)
	private SolutionComment solutionComment;

	public SolutionComment getSolutionComment() {
		return solutionComment;
	}

	public void setSolutionComment(SolutionComment solutionComment) {
		this.solutionComment = solutionComment;
	}

}
