package com.rhizome.domain;

public class HotSolutionTopics {

	private long solutionId;
	private String solutionTitle;
	private long totalComments;
	private long totalLikes;
	private long totalOfCommehtsLikes;
	
	
	public long getSolutionId() {
		return solutionId;
	}
	public void setSolutionId(long solutionId) {
		this.solutionId = solutionId;
	}
	public String getSolutionTitle() {
		return solutionTitle;
	}
	public void setSolutionTitle(String solutionTitle) {
		this.solutionTitle = solutionTitle;
	}
	public long getTotalComments() {
		return totalComments;
	}
	public void setTotalComments(long totalComments) {
		this.totalComments = totalComments;
	}
	public long getTotalLikes() {
		return totalLikes;
	}
	public void setTotalLikes(long totalLikes) {
		this.totalLikes = totalLikes;
	}
	public long getTotalOfCommehtsLikes() {
		return totalOfCommehtsLikes;
	}
	public void setTotalOfCommehtsLikes(long totalOfCommehtsLikes) {
		this.totalOfCommehtsLikes = totalOfCommehtsLikes;
	}
}
