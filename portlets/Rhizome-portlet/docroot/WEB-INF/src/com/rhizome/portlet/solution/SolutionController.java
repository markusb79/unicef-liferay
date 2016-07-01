package com.rhizome.portlet.solution;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.WebKeys;
import com.liferay.portal.model.Role;
import com.liferay.portal.model.User;
import com.liferay.portal.service.RoleLocalServiceUtil;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.asset.model.AssetCategory;
import com.rhizome.domain.SocialWorkflow;
import com.rhizome.domain.Solution;
import com.rhizome.domain.SolutionComment;
import com.rhizome.domain.SolutionCommentLike;
import com.rhizome.service.SocialWorkflowService;
import com.rhizome.service.SolutionCommentLikeService;
import com.rhizome.service.SolutionCommentService;
import com.rhizome.service.SolutionService;
import com.rhizome.util.CommonUtil;
import com.rhizome.util.SocialWorkflowEnum;
import com.rhizome.util.SolutionEnum;
import com.rhizome.util.SolutionUtil;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.portlet.bind.annotation.ActionMapping;
import org.springframework.web.portlet.bind.annotation.RenderMapping;
import org.springframework.web.portlet.bind.annotation.ResourceMapping;

@Controller
@RequestMapping("VIEW")
public class SolutionController {
	private static final Log log = LogFactoryUtil.getLog(SolutionController.class);
	
	private static final String SOLUTION_FORM_JSP = "solutionForm";
	private static final String SOLUTION_VIEW_JSP = "solutionView";
	private static final String SOLUTION_COMMENT_JSP = "solutionComment";
	private static final String SOLUTION_COMMENT_REPLY_JSP = "solutionReplyComment";
	private static final String MOST_RECENT_LIST = "most_recent";
	private static final String SOLUTION_FORM_RESPONSE_JSP = "most_recent_response";
	@Autowired
	private SolutionService solutionService;
	
	@Autowired
	private SocialWorkflowService socialWorkflowService;
	
	@Autowired
	private SolutionCommentService solutionCommentService;
	
	@Autowired
	private SolutionCommentLikeService solutionCommentLikeService;
	
	@RenderMapping
	public String view(Locale locale, Model model, RenderRequest renderRequest,RenderResponse renderResponse) {
		ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
		List<Solution> solutions = null;
		List<AssetCategory> solutionCategoryList=null;
		List<AssetCategory> solutionProgrammeList =null;
		List<AssetCategory> solutionStageList=null;
		List<AssetCategory> solutionTypeList=null;
		User user = null;
		String avatarURL = StringPool.BLANK;
		boolean isCoachUser = false;
		Role role = null;
		try{
			solutionCategoryList = CommonUtil.getSolutionCategory(themeDisplay.getScopeGroupId(),themeDisplay.getUserId());
			solutionProgrammeList = CommonUtil.getSolutionProgramme(themeDisplay.getScopeGroupId(),themeDisplay.getUserId());
			solutionStageList = CommonUtil.getsolutionStageList(themeDisplay.getScopeGroupId(),themeDisplay.getUserId());
			solutionTypeList = CommonUtil.getSolutionSpaceList(themeDisplay.getScopeGroupId(),themeDisplay.getUserId());	
			user = themeDisplay.getUser(); 
			avatarURL = CommonUtil.getAvatarURL(user.getUserId());
			solutions = solutionService.getRecentSolution();
			role = RoleLocalServiceUtil.getRole(themeDisplay.getCompanyId(), "coach");
			isCoachUser = RoleLocalServiceUtil.hasUserRole(themeDisplay.getUserId(), role.getRoleId());

			model.addAttribute("isCoachUser", isCoachUser); 
			model.addAttribute("solutionCategoryList", solutionCategoryList);
			model.addAttribute("solutionProgrammeList", solutionProgrammeList);
			model.addAttribute("solutionTypeList", solutionTypeList);
			model.addAttribute("stageList", solutionStageList);
			model.addAttribute("avatarURL", avatarURL);
			model.addAttribute("userName", user.getFirstName() + " " + user.getLastName());
			model.addAttribute("solutionList", solutions);
		}catch(Exception e){
			log.error("Error in Getting Create Solution Method"+e.getMessage());
		}
		return SOLUTION_FORM_JSP;
	}
	@ResourceMapping(value="getSolutionDataURL")
	public String getSolutionDataURL(ResourceRequest resourceRequest,ResourceResponse resourceResponse,Model model){
		HttpServletRequest request = PortalUtil
				.getOriginalServletRequest(PortalUtil
						.getHttpServletRequest(resourceRequest));
		
		int recordsSize = Integer.parseInt(request.getParameter("recordsPerPage"));
		int pageNo = Integer.parseInt(request.getParameter("pageNo"));
		long start = (long) (pageNo * recordsSize) - recordsSize;
		List<Solution> solutions = new ArrayList<Solution>();
		try{
			solutions = solutionService.getRecentSolutionByPageNumber(start,recordsSize);
			
			model.addAttribute("noOfSolutions", solutions.size());
			model.addAttribute("solutionList", solutions);
		}catch(Exception e){
			log.error("Error in Getting Most Recent Solution List"+e.getMessage());
		}
		return SOLUTION_FORM_RESPONSE_JSP;
		
	}
	@RenderMapping(params="view=viewMostRecentURL")
	public String viewMostRecentURL(RenderRequest renderRequest,RenderResponse renderResponse,Model model){
		
		try{
			model.addAttribute("noOfSolutions", solutionService.findAll().size());
		}catch(Exception e){
			log.error("Error in Getting Most Recent Solution List"+e.getMessage());
		}

		return MOST_RECENT_LIST;
		
		
	}
	@ActionMapping(params="action=saveSolution")
	public void saveSolution(ActionRequest actionRequest,ActionResponse actionResponse){
		ThemeDisplay themeDisplay = (ThemeDisplay) actionRequest.getAttribute(WebKeys.THEME_DISPLAY);
		
		if(!themeDisplay.isSignedIn()){
			SessionErrors.add(actionRequest, SolutionConstant.ERROR_SOLUTION_LOG_IN);
			return;
		}
		long solutionId = ParamUtil.getLong(actionRequest, "solutionId",0);
		String solutionTitle = ParamUtil.getString(actionRequest, "solutionTitle",StringPool.BLANK);
		long solutionProgramme = ParamUtil.getLong(actionRequest, "solutionProgramme",0);
		long solutionStage = ParamUtil.getLong(actionRequest, "stage",0);
		long solutionSpace = ParamUtil.getLong(actionRequest, "solutionSpace",0);
		long solutionCategory = ParamUtil.getLong(actionRequest, "category",0);
		String solutionContent = ParamUtil.getString(actionRequest, "answerContent",StringPool.BLANK);
		
		Solution solution = null;
		SocialWorkflow socialWorkflow = null;
		if(solutionId > 0){
			solution = solutionService.find(solutionId);
		}else{
			solution = new Solution();
			solution.setSubmissionDate(new Date());
		}
		solution.setSolutionTitle(solutionTitle);
		solution.setSolutionProgramme(solutionProgramme);
		solution.setSolutionStage(solutionStage);
		solution.setSpaceId(solutionSpace);
		solution.setSolutionCategory(solutionCategory);
		solution.setStatus(SolutionEnum.SOLUTION_BACKLOG.getValue());
		solution.setDescription(solutionContent);
		solution.setCompanyId(themeDisplay.getCompanyId());
		solution.setModifiedDate(new Date());
		solution.setCoInventorId(themeDisplay.getUserId());
		solution.setGroupId(themeDisplay.getScopeGroupId());
		solution.setSolutionHot(Boolean.FALSE);
		solution.setHotWeight(0.0);
		boolean isUpdated = true;
		if(solutionId > 0){
				solutionService.update(solution);
				socialWorkflow = createSolutionWorkflow(solution,themeDisplay,socialWorkflow,isUpdated);
				SessionMessages.add(actionRequest, SolutionConstant.SUCCESS_SOLUTION_MESSAGE_UPDATE);
		}else{
				isUpdated = false;
				solutionService.create(solution);
				socialWorkflow = createSolutionWorkflow(solution,themeDisplay,socialWorkflow,isUpdated);
				SessionMessages.add(actionRequest,SolutionConstant.SUCCESS_SOLUTION_MESSAGE_CREATE);
		}
	}
	private SocialWorkflow createSolutionWorkflow(Solution solution,
			ThemeDisplay themeDisplay, SocialWorkflow socialWorkflow,
			boolean isUpdated) {
		
		if(isUpdated){
			socialWorkflow = socialWorkflowService.findWorkflowFromSolutionId(solution.getSolutionId());
			socialWorkflow.setModifiedDate(new Date());
			socialWorkflow.setDescription(solution.getDescription());
			socialWorkflow.setAction(SolutionConstant.SUBMITTED_A_SOLUTION);
			socialWorkflow.setActor(themeDisplay.getUserId());
			socialWorkflow.setSolution(solution);
			if(socialWorkflow.getStatus()== SocialWorkflowEnum.WORKFLOW_DRAFT.getValue()){
				socialWorkflow.setTimeNeeded(0L);
				socialWorkflow.setStatus(SocialWorkflowEnum.WORKFLOW_DRAFT.getValue());
			}
			socialWorkflowService.update(socialWorkflow);
		}else{
			socialWorkflow = new SocialWorkflow();
			socialWorkflow.setCreatedDate(new Date());
			socialWorkflow.setModifiedDate(new Date());
			socialWorkflow.setDescription(solution.getDescription());
			socialWorkflow.setAction(SolutionConstant.SUBMITTED_A_SOLUTION);
			socialWorkflow.setActor(themeDisplay.getUserId());
			socialWorkflow.setSolution(solution);
			socialWorkflow.setApp(SolutionEnum.SOLUTION_BACKLOG.getValue());
			socialWorkflow.setTimeNeeded(0L);
			socialWorkflow.setStatus(SocialWorkflowEnum.WORKFLOW_DRAFT.getValue());
			socialWorkflowService.create(socialWorkflow);
		}
		return socialWorkflow;
	}
	@RenderMapping(params="view=viewSolution")
	public String viewSolution(RenderRequest renderRequest,RenderResponse renderResponse,Model model){
				ThemeDisplay themeDisplay = (ThemeDisplay) renderRequest.getAttribute(WebKeys.THEME_DISPLAY);
				long solutionId = ParamUtil.getLong(renderRequest, "solutionId",0);
				
				Solution solution = solutionService.find(solutionId);
				User user=null;
				String userIcon=StringPool.BLANK;
				String userDisplayURL = StringPool.BLANK;
				List<AssetCategory> solutionCategoryList=null;
				List<AssetCategory> solutionProgrammeList =null;
				List<AssetCategory> solutionStageList=null;
				List<AssetCategory> solutionTypeList=null;
				try {
					user = UserLocalServiceUtil.getUser(solution.getCoInventorId());
					userIcon =  (user.getPortraitId() > 0 ?  CommonUtil.getUserImagePath(user.getPortraitId()) : CommonUtil.getUserImagePathScreenName(user.getScreenName(), user.getCompanyId()));
					userDisplayURL = user.getDisplayURL(themeDisplay);
					
					solutionCategoryList = SolutionUtil.getSolutionCategory(themeDisplay.getScopeGroupId(),themeDisplay.getUserId());
					 solutionProgrammeList = SolutionUtil.getSolutionProgramme(themeDisplay.getScopeGroupId(),themeDisplay.getUserId());
					 solutionStageList = SolutionUtil.getsolutionStageList(themeDisplay.getScopeGroupId(),themeDisplay.getUserId());
					 solutionTypeList = SolutionUtil.getSolutionSpaceList(themeDisplay.getScopeGroupId(),themeDisplay.getUserId());
					/*add entry in solutionView*/
				    String submissionDate = new SimpleDateFormat("MMM dd, YYYY").format(solution.getSubmissionDate()).toUpperCase();
					model.addAttribute("createdDate", submissionDate);
					model.addAttribute("isPrmoted", (solution.getStatus() == SolutionEnum.SOLUTION_SCRUM.getValue() ? true : false));
					model.addAttribute("solution", solution);
					model.addAttribute("userAvtar", userIcon);
					model.addAttribute("coInventorName", user.getFullName());
					model.addAttribute("userDisplayURL", userDisplayURL);
					
					model.addAttribute("solutionCategoryList", solutionCategoryList);
					model.addAttribute("solutionProgrammeList", solutionProgrammeList);
					model.addAttribute("solutionTypeList", solutionTypeList);
					model.addAttribute("stageList", solutionStageList);
					
				} catch (PortalException e) {
					log.error("Error in getting view Solution Method"+e.getMessage());
				} catch (SystemException e) {
					log.error("Error in getting view Solution Method"+e.getMessage());
				}
				return SOLUTION_VIEW_JSP;
	}
	@ResourceMapping(value = "postSolutionComment")
	public void postSolutionComment(ResourceRequest resourceRequest,ResourceResponse resourceResponse,Model model){
				 HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
				 ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
				  long solutionId = ParamUtil.getLong(request, "solutionId");
				  String comment = ParamUtil.getString(request, "commentText");
				  try{
					  Solution solution = solutionService.find(solutionId);
					  
					  SolutionComment solutionComment = new SolutionComment();
					  solutionComment.setCompanyId(themeDisplay.getCompanyId());
					  solutionComment.setCreatedDate(new Date());
					  solutionComment.setParentCommentId(0);
					  solutionComment.setDescription(comment);
					  solutionComment.setGroupId(themeDisplay.getScopeGroupId());
					  solutionComment.setUserId(themeDisplay.getUserId());
					  solutionComment.setTaskId(0);
					  solutionComment.setSolution(solution);
					  solutionCommentService.create(solutionComment); 
				  }catch(Exception e){
					  log.error("Error in Getting Post Solution Comment Method"+e.getMessage());
				  }
	}
	@ResourceMapping(value="solutionComment")
	public String solutionComment(ResourceRequest resourceRequest,ResourceResponse resourceResponse,Model model){
				 HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
				 long solutionId = ParamUtil.getLong(request, "solutionId");
				 try{
					 List<SolutionComment> solutionComments = solutionCommentService.getListOfSolutionComment(solutionId, 0);
					
					 model.addAttribute("solutionId", solutionId);
					 model.addAttribute("commentCount", solutionComments.size());
					 model.addAttribute("comments", solutionComments);
					 model.addAttribute("solutionCommentLikeService", solutionCommentLikeService);
					 model.addAttribute("solutionCommentService", solutionCommentService);
				 }catch(Exception e){
					 log.error("Error in Getting Solution Comment Method"+e.getMessage());
				 }
				 return SOLUTION_COMMENT_JSP;
	} 	
	
	@ResourceMapping(value="likeComment")
	public String likeComment(ResourceRequest resourceRequest,ResourceResponse resourceResponse,Model model){
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long solutionId = ParamUtil.getLong(request, "solutionId");
		long commentId = ParamUtil.getLong(request, "commentId");
		String like = ParamUtil.getString(request, "like");
		PrintWriter pw = null;
		try{
			Solution solution = solutionService.find(solutionId);
			SolutionComment solutionComment = solutionCommentService.find(commentId);
			if(like.equalsIgnoreCase("Like")){
				SolutionCommentLike commentLike = new SolutionCommentLike();
				commentLike.setLikedDate(new Date());
				commentLike.setUserId(themeDisplay.getUserId());
				commentLike.setSolution(solution);
				commentLike.setSolutionComment(solutionComment);
				solutionCommentLikeService.create(commentLike);
			}else if(like.equalsIgnoreCase("Liked")){
				solutionCommentLikeService.deleteSolutionCommentLike(themeDisplay.getUserId(), solutionId, commentId);	
			}

			long likeCount = solutionCommentLikeService.getCurrentCommentLikeCount(solutionId, commentId);
			pw = null;
			pw = resourceResponse.getWriter();
			pw.print(likeCount);
			pw.flush();
		}catch(Exception e){
			log.error("Error in Getting Solution Comment Method"+e.getMessage());
		}finally{
			pw.close();
		}
		return SOLUTION_COMMENT_JSP;
	}			
	
	@ResourceMapping(value="replyComment")
	public String replyComment(ResourceRequest resourceRequest,ResourceResponse resourceResponse,Model model){
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
		ThemeDisplay themeDisplay = (ThemeDisplay) resourceRequest.getAttribute(WebKeys.THEME_DISPLAY);
		long solutionId = ParamUtil.getLong(request, "solutionId");
		long commentId = ParamUtil.getLong(request, "commentId");
		String replyComment = ParamUtil.getString(request, "replyComment");
		
		List<SolutionComment> solutionComments = new ArrayList<SolutionComment>();
		try{
			  Solution solution = solutionService.find(solutionId);
			  SolutionComment solutionComment = new SolutionComment();
			  solutionComment.setCompanyId(themeDisplay.getCompanyId());
			  solutionComment.setCreatedDate(new Date());
			  solutionComment.setParentCommentId(commentId);
			  solutionComment.setDescription(replyComment);
			  solutionComment.setGroupId(themeDisplay.getScopeGroupId());
			  solutionComment.setUserId(themeDisplay.getUserId());
			  solutionComment.setTaskId(0);
			  solutionComment.setSolution(solution);
			  solutionCommentService.create(solutionComment); 
			  
			  solutionComments = solutionCommentService.getListOfSolutionReplyComment(solutionId, commentId);
			  model.addAttribute("solutionComments", solutionComments); 
			  model.addAttribute("solutionId", solutionId); 
			  model.addAttribute("commentId", commentId);
		  }catch(Exception e){
			  log.error("Error in Getting Post Reply of comment of the solution Method - "+e.getMessage());
		  }finally{
		  }
		return SOLUTION_COMMENT_REPLY_JSP;
	}
	
	@ResourceMapping(value="replyCommentView")
	public String replyCommentView(ResourceRequest resourceRequest,ResourceResponse resourceResponse,Model model){
		HttpServletRequest request = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(resourceRequest));
		long solutionId = ParamUtil.getLong(request, "solutionId");
		long commentId = ParamUtil.getLong(request, "commentId");
		List<SolutionComment> solutionComments = new ArrayList<SolutionComment>();

		try{
			  solutionComments = solutionCommentService.getListOfSolutionReplyComment(solutionId, commentId);
			  model.addAttribute("solutionComments", solutionComments); 
			  model.addAttribute("solutionId", solutionId); 
			  model.addAttribute("commentId", commentId); 
		  }catch(Exception e){
			  log.error("Error in Getting Post Reply of comment of the solution Method - "+e.getMessage());
		  }finally{
		  }
		
		return SOLUTION_COMMENT_REPLY_JSP;
	}
}
