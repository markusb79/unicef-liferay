package com.rhizome.portlet.hotpolioanswers;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.xml.DocumentException;
import com.rhizome.domain.HotSolutionTopics;
import com.rhizome.domain.Solution;
import com.rhizome.domain.SolutionComment;
import com.rhizome.domain.SolutionCommentLike;
import com.rhizome.service.SolutionCommentLikeService;
import com.rhizome.service.SolutionCommentService;
import com.rhizome.service.SolutionService;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Locale;

import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.bind.annotation.RenderMapping;

@Controller
@RequestMapping("VIEW")
public class HotPolioAnswersController {
	
	@Autowired
	private SolutionService solutionService;
	
	@Autowired
	private SolutionCommentService solutionCommentService;
	
	@Autowired
	private SolutionCommentLikeService solutionCommentLikeService;
	
	@RenderMapping
	public String view(Locale locale, Model model, RenderRequest renderRequest,RenderResponse renderResponse) throws PortalException, SystemException, DocumentException{
		List<Solution> solutionList = new ArrayList<Solution>();
		solutionList = solutionService.findAll();
		long totalComments=0;
		long totalCommentLikes=0;
		List<HotSolutionTopics> hotSolutionTopicsList = new ArrayList<HotSolutionTopics>();
		for(Solution solutionObj : solutionList){
			totalComments = solutionCommentService.getTotalCommentsBySolutionId(solutionObj.getSolutionId());
			totalCommentLikes = solutionCommentLikeService.getTotalSolutionLikeBySolutionId(solutionObj.getSolutionId());
			HotSolutionTopics hotSolutionsObj = new HotSolutionTopics();
			hotSolutionsObj.setSolutionId(solutionObj.getSolutionId());
			hotSolutionsObj.setSolutionTitle(solutionObj.getSolutionTitle());
			hotSolutionsObj.setTotalComments(totalComments);
			hotSolutionsObj.setTotalLikes(totalCommentLikes);
			hotSolutionsObj.setTotalOfCommehtsLikes(totalComments+totalCommentLikes);
			hotSolutionTopicsList.add(hotSolutionsObj);
		}
		
		
		Collections.sort(hotSolutionTopicsList , hotSolutionDESCComparator);
		model.addAttribute("hotSolutionTopicsList", hotSolutionTopicsList);
		
		
		return "view";
	}
	
	private static Comparator<HotSolutionTopics> hotSolutionASCComparator = null;
	private static Comparator<HotSolutionTopics> hotSolutionDESCComparator = null;
	 static {
		 hotSolutionASCComparator = new Comparator<HotSolutionTopics>() {
		   public int compare(HotSolutionTopics a, HotSolutionTopics b) {
		    return (a.getTotalOfCommehtsLikes() < b.getTotalOfCommehtsLikes()) ? -1: (a.getTotalOfCommehtsLikes() > b.getTotalOfCommehtsLikes()) ? 1:0 ;
		   }
		 };
		 hotSolutionDESCComparator = new Comparator<HotSolutionTopics>() {
			   public int compare(HotSolutionTopics a, HotSolutionTopics b) {
			    return (a.getTotalOfCommehtsLikes() > b.getTotalOfCommehtsLikes()) ? -1: (a.getTotalOfCommehtsLikes() < b.getTotalOfCommehtsLikes()) ? 1:0 ;
			   }
			 };
	 }
	 
}
