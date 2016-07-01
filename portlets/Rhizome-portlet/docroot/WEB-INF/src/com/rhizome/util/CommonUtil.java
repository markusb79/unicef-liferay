package com.rhizome.util;

import com.liferay.portal.kernel.dao.orm.DynamicQuery;
import com.liferay.portal.kernel.dao.orm.DynamicQueryFactoryUtil;
import com.liferay.portal.kernel.dao.orm.PropertyFactoryUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.util.PropsUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.User;
import com.liferay.portal.service.ServiceContext;
import com.liferay.portal.service.UserLocalServiceUtil;
import com.liferay.portlet.asset.model.AssetCategory;
import com.liferay.portlet.asset.model.AssetVocabulary;
import com.liferay.portlet.asset.service.AssetCategoryLocalServiceUtil;
import com.liferay.portlet.asset.service.AssetVocabularyLocalServiceUtil;
import com.liferay.portlet.journal.model.JournalArticle;
import com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.portlet.PortletURL;

import com.liferay.portal.model.Layout;

import javax.servlet.http.HttpServletRequest;

import com.rhizome.constants.Constants;
import com.liferay.portlet.PortletURLFactoryUtil;

import javax.portlet.PortletMode;
import javax.portlet.WindowState;

public class CommonUtil {
	
	private static final Log log = LogFactoryUtil.getLog(CommonUtil.class);

	static ServiceContext serviceContext = new ServiceContext();
	
	public static List<AssetCategory> getSolutionCategory(long scopeGroupId,
			long userId) throws PortalException, SystemException {
		List<AssetCategory> categoryList = new ArrayList<AssetCategory>();
		AssetVocabulary categoryAssetVocabulary=null;
		
			
			try {
				categoryAssetVocabulary = AssetVocabularyLocalServiceUtil.getGroupVocabulary(scopeGroupId, "Category");
			} catch (PortalException e) {
				serviceContext.setScopeGroupId(scopeGroupId);
				categoryAssetVocabulary = AssetVocabularyLocalServiceUtil.addVocabulary(userId, PropsUtil.get("unicef.idea.category"), serviceContext);
			} catch (SystemException e) {
				e.printStackTrace();
			}
			long categoryVocabularyId = categoryAssetVocabulary.getVocabularyId();

			DynamicQuery query = DynamicQueryFactoryUtil.forClass(AssetCategory.class);
			query.add(PropertyFactoryUtil.forName("vocabularyId").eq(categoryVocabularyId));
			query.add(PropertyFactoryUtil.forName("parentCategoryId").eq(Long.parseLong("0")));
			try {
				categoryList = AssetCategoryLocalServiceUtil.dynamicQuery(query, -1, -1);
			} catch (SystemException e) {
				log.error("No Category List Found"+e.getMessage());
			}
		
		return categoryList;
	}

		public static List<AssetCategory> getSolutionProgramme(long scopeGroupId,
			long userId) throws PortalException, SystemException {
		List<AssetCategory> ideaContestList =new ArrayList<AssetCategory>();
		AssetVocabulary ideaContestAssetVocabulary = null;
		try {
			ideaContestAssetVocabulary = AssetVocabularyLocalServiceUtil.getGroupVocabulary(scopeGroupId, "Solution Program");
		} catch (PortalException e) {
			serviceContext.setScopeGroupId(scopeGroupId);
			ideaContestAssetVocabulary = AssetVocabularyLocalServiceUtil.addVocabulary(userId, PropsUtil.get("unicef.idea.solution.program"), serviceContext);
			log.error("Portal Exception Called"+e.getMessage());
		} catch (SystemException e) {
			log.error("System exception called"+e.getMessage());
		}
		long ideaContestVocabularyId = ideaContestAssetVocabulary.getVocabularyId();
		try {
			ideaContestList = AssetCategoryLocalServiceUtil.getVocabularyCategories(ideaContestVocabularyId, -1, -1, null);
		} catch (SystemException e) {
			log.error("No List Found Of Idea Contest"+e.getMessage());
		}
		return ideaContestList;
	}

		public static List<AssetCategory> getsolutionStageList(long scopeGroupId,
				long userId) throws PortalException, SystemException {
			List<AssetCategory> stageList = new ArrayList<AssetCategory>();
			AssetVocabulary stageAssetVocabulary=null;
			
				try {
					stageAssetVocabulary = AssetVocabularyLocalServiceUtil.getGroupVocabulary(scopeGroupId, "Solution Stage");
				} catch (PortalException e) {
					serviceContext.setScopeGroupId(scopeGroupId);
					stageAssetVocabulary = AssetVocabularyLocalServiceUtil.addVocabulary(userId, PropsUtil.get("unicef.solution.stage"), serviceContext);
				} catch (SystemException e) {
					e.printStackTrace();
				}
				
				long stageVocabularyId = stageAssetVocabulary.getVocabularyId();
				try {
					stageList = AssetCategoryLocalServiceUtil.getVocabularyCategories(stageVocabularyId, -1, -1, null);
				} catch (SystemException e) {
					log.error("No Stage Category found"+e.getMessage());
				}
			return stageList;
		}

		public static List<AssetCategory> getSolutionSpaceList(long scopeGroupId,
				long userId) throws PortalException, SystemException {
			List<AssetCategory> ideaTypeList = new ArrayList<AssetCategory>();
			AssetVocabulary ideaAssetVocabulary=null;
			
				try {
					ideaAssetVocabulary = AssetVocabularyLocalServiceUtil.getGroupVocabulary(scopeGroupId, "Solution Space");
				} catch (PortalException e) {
					serviceContext.setScopeGroupId(scopeGroupId);
					ideaAssetVocabulary = AssetVocabularyLocalServiceUtil.addVocabulary(userId, PropsUtil.get("unicef.solution.space"), serviceContext);
				} catch (SystemException e) {
					e.printStackTrace();
				}
				long ideaVocabularyId = ideaAssetVocabulary.getVocabularyId();
				try {
					ideaTypeList = AssetCategoryLocalServiceUtil.getVocabularyCategories(ideaVocabularyId, -1, -1, null);
				} catch (SystemException e) {
					log.error("Solution Type List Not Found"+e.getMessage());
				}
			
			return ideaTypeList;
		}

		public static String getAvatarURL(long userId){
			User user = null;
			String avatarURL = StringPool.BLANK;
			try {
				user = UserLocalServiceUtil.getUser(userId);
			} catch (PortalException e) {
				log.error("Error in Getting User in IdeaScrumDiscussion"+e.getMessage());
			} catch (SystemException e) {
				log.error("Error in Getting User in IdeaScrumDiscussion"+e.getMessage());
			}
			if(Validator.isNotNull(user)){
				avatarURL = user.getPortraitId() > 0 ? CommonUtil.getUserImagePath(user
						.getPortraitId()) : CommonUtil.getUserImagePathScreenName(
						user.getScreenName(), user.getCompanyId());
			}
			return avatarURL;
		}
		public static String getUserImagePath(long userId) {
			  return "/image/user_portrait?img_id="+userId;
		}
		public static String getUserImagePathScreenName(String screenName, long companyId) {
			   return PropsUtil.get("image.default.user.male.portrait.properties");
		}
		
		public static PortletURL createSolutionPortletURL(HttpServletRequest request, long currentPagePlid, long entryId, long groupId){
			PortletURL customPortletURL = null;
			try {
				Layout ideaLayout =  SolutionUtil.getSolutionGeneratorLayout(groupId);
				if(Validator.isNotNull(ideaLayout)){
					customPortletURL =  PortletURLFactoryUtil.create(request, Constants.SOLUTION_PORTLET_ID, ideaLayout.getPlid() , "RENDER_PHASE");
				}else{
					customPortletURL =  PortletURLFactoryUtil.create(request, Constants.SOLUTION_PORTLET_ID, currentPagePlid , "RENDER_PHASE");
				}
				customPortletURL.setWindowState(WindowState.NORMAL);
				customPortletURL.setPortletMode(PortletMode.VIEW);
				customPortletURL.setParameter("solutionId",String.valueOf(entryId));
				customPortletURL.setParameter("view","viewSolution");
			} catch (Exception e) {
				log.error("Error in creating solution portlet URL:"+e.getMessage());
			}
			return customPortletURL;
		}
		
		public static boolean getDateInRange(Date fromDate, Date toDate, Date d){
			return d.compareTo(fromDate) >= 0 && d.compareTo(toDate) <= 0;
		}
		
		public static PortletURL createSOPPortletURL(HttpServletRequest request, long currentPagePlid, long entryId, long assetEntryId, long groupId) throws PortalException, SystemException{
			PortletURL customPortletURL = null;
			
			 JournalArticle article =  JournalArticleLocalServiceUtil.getLatestArticle(entryId);
			try {
				Layout SOPLayout =  SOPUtil.getSOPLayout(groupId);
				if(Validator.isNotNull(SOPLayout)){
					customPortletURL =  PortletURLFactoryUtil.create(request, Constants.SOP_PORTLET_ID, SOPLayout.getPlid() , "RENDER_PHASE");
				}else{
					customPortletURL =  PortletURLFactoryUtil.create(request, Constants.SOP_PORTLET_ID, currentPagePlid , "RENDER_PHASE");
				}
				customPortletURL.setWindowState(WindowState.NORMAL);
				customPortletURL.setPortletMode(PortletMode.VIEW);
				customPortletURL.setParameter("view","viewSOPArticle");
				customPortletURL.setParameter("articleId",String.valueOf(article.getId()));
			} catch (Exception e) {
				log.error("Error in creating solution portlet URL:"+e.getMessage());
			}
			return customPortletURL;
		}
		
		public static PortletURL createC4DPortletURL(HttpServletRequest request, long currentPagePlid, long entryId, long assetEntryId, long groupId) throws PortalException, SystemException{
			PortletURL customPortletURL = null;
			
			 JournalArticle article =  JournalArticleLocalServiceUtil.getLatestArticle(entryId);
			try {
				Layout C4DLayout =  C4DUtil.getC4DLayout(groupId);
				if(Validator.isNotNull(C4DLayout)){
					customPortletURL =  PortletURLFactoryUtil.create(request, Constants.C4D_PORTLET_ID, C4DLayout.getPlid() , "RENDER_PHASE");
				}else{
					customPortletURL =  PortletURLFactoryUtil.create(request, Constants.C4D_PORTLET_ID, currentPagePlid , "RENDER_PHASE");
				}
				customPortletURL.setWindowState(WindowState.NORMAL);
				customPortletURL.setPortletMode(PortletMode.VIEW);
				customPortletURL.setParameter("view","viewC4DArticle");
				customPortletURL.setParameter("articleId",String.valueOf(article.getId()));
			} catch (Exception e) {
				log.error("Error in creating solution portlet URL:"+e.getMessage());
			}
			return customPortletURL;
		}
}
