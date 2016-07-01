package com.rhizome.util;

import com.liferay.portal.kernel.dao.orm.DynamicQuery;
import com.liferay.portal.kernel.dao.orm.DynamicQueryFactoryUtil;
import com.liferay.portal.kernel.dao.orm.PropertyFactoryUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.util.PropsUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.Layout;
import com.liferay.portal.service.LayoutLocalServiceUtil;
import com.liferay.portal.service.ServiceContext;
import com.liferay.portlet.asset.model.AssetCategory;
import com.liferay.portlet.asset.model.AssetVocabulary;
import com.liferay.portlet.asset.service.AssetCategoryLocalServiceUtil;
import com.liferay.portlet.asset.service.AssetVocabularyLocalServiceUtil;
import com.rhizome.domain.Solution;
import com.rhizome.service.SolutionService;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class SolutionUtil {

	private static final Log log = LogFactoryUtil.getLog(SolutionUtil.class);
	static ServiceContext serviceContext = new ServiceContext();
	private static final String SOLUTION_FRIENDLY_URL_LAYOUT = PropsUtil.get("solution-generator-friendly-layout");
	
	private static SolutionService solutionService;
	
	@Autowired
	private SolutionUtil(SolutionService solutionService){
		SolutionUtil.solutionService = solutionService;
	}
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
	
	public static Solution getSolution(long solutionId){
		return solutionService.find(solutionId);
	}
	
	public static List<Solution> getSolutionList(){
		return solutionService.solutionList();
		
	}
	
	 public static long getAssetCategoryIdByCatNameAndVocName(String vocabularyName, String categoryName) {
		 long vocabularyId = getAssetVocabularyIdByName(vocabularyName);
		 long categoryId = 0;
		 if(vocabularyId > 0){
			 List<AssetCategory> assetCategory;
			 DynamicQuery query = DynamicQueryFactoryUtil.forClass(AssetCategory.class);
			 query.add(PropertyFactoryUtil.forName("name").eq(categoryName));
			 query.add(PropertyFactoryUtil.forName("vocabularyId").eq(vocabularyId));
			 try {
				 assetCategory =(List<AssetCategory>) AssetCategoryLocalServiceUtil.dynamicQuery(query);
				 categoryId = assetCategory.get(0).getCategoryId();
			 } catch (SystemException e) {
				log.error("No Category found ");
			 }
		 }
		 return categoryId;
	}
	
	 public static long getAssetVocabularyIdByName(String name) {
		 long vocabularyId = 0;
		 List<AssetVocabulary> assetVocabularies;
		 DynamicQuery query = DynamicQueryFactoryUtil.forClass(AssetVocabulary.class);
		 query.add(PropertyFactoryUtil.forName("name").eq(name));
		 try {
			 assetVocabularies =(List<AssetVocabulary>) AssetVocabularyLocalServiceUtil.dynamicQuery(query);
			 vocabularyId = assetVocabularies.get(0).getVocabularyId();
		 } catch (SystemException e) {
			log.error("No Vocabulary found ");
		 }
		return vocabularyId;
	}
	 
	public static Layout getSolutionGeneratorLayout(long groupId){
			Layout solutionLayout = null;
			try {
				solutionLayout = LayoutLocalServiceUtil.getFriendlyURLLayout(groupId, Boolean.TRUE, getSolutionFriendlyLayoutURL());
			} catch (PortalException e) {
				log.error("Error in getting solution layout:"+e.getMessage());
			} catch(SystemException e) {
				log.error("Error in getting solution layout:"+e.getMessage());
			}
			return solutionLayout;
			
	}
	
	public static String getSolutionFriendlyLayoutURL(){
		if(Validator.isNotNull(SOLUTION_FRIENDLY_URL_LAYOUT)){
			return SOLUTION_FRIENDLY_URL_LAYOUT;
		}
		return "/polio-answer-community";
	}

	public static boolean isSolutionNew(int newTHRESHOLD, Date createdDate){
		 
	    Calendar previousCal = Calendar.getInstance();
	    previousCal.add(Calendar.DATE, - newTHRESHOLD);
        Date fromDate = previousCal.getTime();
        
        Calendar fromCal = Calendar.getInstance();
        Date toDate = fromCal.getTime();
        
		return CommonUtil.getDateInRange(fromDate, toDate, createdDate);
    }
 
	 public static boolean isSolutionHOT(int hotTHRESHOLD, Date createdDate, boolean isSolutionHot, double hotWeight){
		 
		    Calendar previousCal = Calendar.getInstance();
		    previousCal.add(Calendar.DATE, - hotTHRESHOLD);
	        Date fromDate = previousCal.getTime();
	        
	        Calendar fromCal = Calendar.getInstance();
	        Date toDate = fromCal.getTime();
	        
			if(CommonUtil.getDateInRange(fromDate, toDate, createdDate) && isSolutionHot && (hotWeight >= 0.9)){
				return true;
			}
			return false;
	 }
	
}
