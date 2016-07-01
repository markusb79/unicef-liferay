package com.rhizome.portlet.search;

import com.liferay.portal.kernel.dao.orm.DynamicQuery;
import com.liferay.portal.kernel.dao.orm.DynamicQueryFactoryUtil;
import com.liferay.portal.kernel.dao.orm.PropertyFactoryUtil;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.search.Document;
import com.liferay.portal.kernel.search.DocumentImpl;
import com.liferay.portal.kernel.search.DummyIndexer;
import com.liferay.portal.kernel.search.Field;
import com.liferay.portal.kernel.search.Hits;
import com.liferay.portal.kernel.search.Indexer;
import com.liferay.portal.kernel.search.IndexerRegistryUtil;
import com.liferay.portal.kernel.search.SearchEngineUtil;
import com.liferay.portal.kernel.util.ArrayUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.StringPool;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portlet.asset.model.AssetTag;
import com.liferay.portlet.asset.service.AssetTagLocalServiceUtil;
import com.liferay.portlet.blogs.model.BlogsEntry;
import com.liferay.portlet.documentlibrary.model.DLFileEntry;
import com.rhizome.domain.Solution;
import com.rhizome.util.SearchUtil;
import com.rhizome.util.ValueComparator;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map.Entry;
import java.util.TreeMap;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.RenderRequest;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.FacetField;
import org.apache.solr.client.solrj.response.FacetField.Count;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.client.solrj.response.TermsResponse.Term;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.portlet.bind.annotation.ActionMapping;
import org.springframework.web.portlet.bind.annotation.RenderMapping;
import org.springframework.web.portlet.bind.annotation.ResourceMapping;

@Controller
@RequestMapping("VIEW")
public class SearchController {
	
	private static final Log _log = LogFactoryUtil.getLog(SearchController.class);
	
	private static final String VIEW_JSP = "view";
	private static final String SEARCH_JSP = "search";
	
	private SolrServer solr = new HttpSolrServer(SearchUtil.getSOLRServerURL());
	
	private static final String COM_UNICEF_DOMAIN_SEARCH = "com.rhizome.domain.Search";
	public static final String SEARCHED_TITLE = "searchedTitle";
	private static final String PORTLET_ID = "RhizomeSearch_WAR_Rhizomeportlet";
	
	public static final String[] ENGLISH_STOP_WORDS = {
	    "a", "an", "and", "are", "as", "at", "be", "but", "by",
	    "for", "i", "if", "in", "into", "is",
	    "no", "not", "of", "on", "or", "s", "such",
	    "t", "that", "the", "their", "then", "there", "these",
	    "they", "this", "to", "was", "will", "with"
	};
	
	@RenderMapping
	public String view(Locale locale, Model model, RenderRequest renderRequest) {	
		HttpServletRequest httpServletRequest = PortalUtil.getOriginalServletRequest(PortalUtil.getHttpServletRequest(renderRequest));
		
		String from = httpServletRequest.getParameter("from");
		
		String keywords = StringPool.BLANK;
		
		long companyId = PortalUtil.getCompanyId(renderRequest);
		
		/*if(Validator.isNotNull(from) && from.equals("topbar")){
			keywords = httpServletRequest.getParameter("keywords");
		}*/
		int delta = ParamUtil.getInteger(renderRequest, "delta", 20);
		int cur = ParamUtil.getInteger(renderRequest, "cur", 1);
		keywords = ParamUtil.getString(httpServletRequest, "keywords");
		String keywords1 = ParamUtil.getString(renderRequest, "keywords");
		int polioCounter = ParamUtil.getInteger(httpServletRequest, "pc", 0);
		int sopCounter = ParamUtil.getInteger(httpServletRequest, "sc", 0);
		int c4dCounter = ParamUtil.getInteger(httpServletRequest, "cc", 0);
		int time = ParamUtil.getInteger(httpServletRequest, "time");
		boolean isFilter = ParamUtil.getBoolean(renderRequest, "isFilter", Boolean.FALSE);
		boolean isAdvanceSearch = ParamUtil.getBoolean(renderRequest, "isAdvanceSearch", Boolean.FALSE);
		String entryClassName = ParamUtil.getString(renderRequest, "entryClassName", StringPool.BLANK);

		String articleDoc = ParamUtil.getString(httpServletRequest, "articleDoc");
		
		//split the terms
		String queryTerms[] = keywords.split(" ");
		
		if(Validator.isNotNull(entryClassName) && isFilter){
			if(Validator.isNotNull(keywords1)){
				keywords = keywords1;
			}
			if(Validator.isNotNull(keywords)){
				doFilterKeyWordsSearch(renderRequest, model, cur, delta, keywords1, entryClassName, companyId, queryTerms);
			}else if(isAdvanceSearch){
				doFilterAdvanceSearch(renderRequest, model, cur, delta, entryClassName);
			}
			
		}else if(isAdvanceSearch){
			doAdvanceSearch(renderRequest, model, cur, delta);
		}else{
			if(Validator.isNotNull(keywords1)){
				keywords = keywords1;
			}
			if(Validator.isNotNull(keywords)){
				doKeyWordsSearch(renderRequest, model, cur, delta, keywords, companyId, queryTerms);
			}
			else if(isAdvanceSearch){
				doAdvanceSearch(renderRequest, model, cur, delta);
			}
		}
		
		model.addAttribute("keywords", keywords);
		model.addAttribute("test_keyword", keywords);
		model.addAttribute("isAdvanceSearch", isAdvanceSearch);
		model.addAttribute("delta", delta);
		model.addAttribute("cur", cur);
		model.addAttribute("timeFilterEntryClassName", entryClassName);
		model.addAttribute("polioCounter", polioCounter);
		model.addAttribute("sopArticlesCounter", sopCounter);
		model.addAttribute("c4dArticlesCounter", c4dCounter);
		
		model.addAttribute("sopArticlesCount", sopCounter);
		model.addAttribute("c4dArticlesCount", c4dCounter);
		
		model.addAttribute("time", time);
		model.addAttribute("articleDoc", articleDoc);
		return VIEW_JSP;
	}
	
	private void doKeyWordsSearch(RenderRequest renderRequest, Model model, int cur, int delta, String keywords, long companyId, String[] queryTerms){
		Hits hits = SearchUtil.searchAll(renderRequest, keywords, StringPool.BLANK, ((cur - 1) * delta), 
				(((cur - 1) * delta)+ delta), StringPool.BLANK);
		hits.setQueryTerms(SearchUtil.generateNewCombinationTerms(queryTerms));
		// Adding search keyword in search index
		Document document = new DocumentImpl();
		long time = new Date().getTime();
		document.addUID(PORTLET_ID, time);
		document.addKeyword(Field.ENTRY_CLASS_NAME, COM_UNICEF_DOMAIN_SEARCH);
		document.addKeyword(Field.ENTRY_CLASS_PK, time);
		document.addKeyword(Field.PORTLET_ID, PORTLET_ID);
		document.addNumber(Field.COMPANY_ID, companyId);
		document.addText(SEARCHED_TITLE, keywords);
		document.addText(Field.TITLE, keywords);
		Indexer indexer = IndexerRegistryUtil.getIndexer(COM_UNICEF_DOMAIN_SEARCH);
		if(Validator.isNull(indexer)) {
			//Adding dummy indexer
			IndexerRegistryUtil.register(COM_UNICEF_DOMAIN_SEARCH, new DummyIndexer());
		}
		try{
			SearchEngineUtil.updateDocument(SearchEngineUtil.getDefaultSearchEngineId(), companyId, document);
		} catch (Exception e) {
			_log.error(e.getMessage(), e);
		}
		HashMap<String, Integer> docsMap = SearchUtil.getDocsMap(renderRequest, keywords, -1, -1);
		model.addAttribute("hits", hits);
		model.addAttribute("docsMap", docsMap);
	}
	
	private void doFilterKeyWordsSearch(RenderRequest renderRequest, Model model, int cur, int delta,
			String keywords, String entryClassName, long companyId, String[] queryTerms){
		Hits hits = SearchUtil.searchAll(renderRequest, keywords, StringPool.BLANK, ((cur - 1) * delta), (((cur - 1) * delta)+ delta), entryClassName);
		hits.setQueryTerms(SearchUtil.generateNewCombinationTerms(queryTerms));
		// Adding search keyword in search index
		Document document = new DocumentImpl();
		long time = new Date().getTime();
		document.addUID(PORTLET_ID, time);
		document.addKeyword(Field.ENTRY_CLASS_NAME, COM_UNICEF_DOMAIN_SEARCH);
		document.addKeyword(Field.ENTRY_CLASS_PK, time);
		document.addKeyword(Field.PORTLET_ID, PORTLET_ID);
		document.addNumber(Field.COMPANY_ID, companyId);
		document.addText(SEARCHED_TITLE, keywords);
		document.addText(Field.TITLE, keywords);
		Indexer indexer = IndexerRegistryUtil.getIndexer(COM_UNICEF_DOMAIN_SEARCH);
		if(Validator.isNull(indexer)) {
			//Adding dummy indexer
			IndexerRegistryUtil.register(COM_UNICEF_DOMAIN_SEARCH, new DummyIndexer());
		}
		try{
			SearchEngineUtil.updateDocument(SearchEngineUtil.getDefaultSearchEngineId(), companyId, document);
		} catch (Exception e) {
			_log.error(e.getMessage(), e);
		}
		HashMap<String, Integer> docsMap = SearchUtil.getDocsMap(renderRequest, keywords, -1, -1); 
		
		model.addAttribute("hits", hits);
		model.addAttribute("docsMap", docsMap);
	}
	
	private void doAdvanceSearch(RenderRequest renderRequest, Model model, int cur, int delta){
		
		String sourceFieldStr = ParamUtil.getString(renderRequest, "sourceField", StringPool.BLANK);
		String typeFieldStr = ParamUtil.getString(renderRequest, "typeField", StringPool.BLANK);
		String stageFieldStr = ParamUtil.getString(renderRequest, "stageField", StringPool.BLANK);
		String fieldFrom = ParamUtil.getString(renderRequest, "fieldFrom", StringPool.BLANK);
		String fieldTo = ParamUtil.getString(renderRequest, "fieldTo", StringPool.BLANK);
		String hotIdeasFieldStr = ParamUtil.getString(renderRequest, "hotIdeasField", StringPool.BLANK);
		String includeTagsStr = ParamUtil.getString(renderRequest, "includeTags", StringPool.BLANK);
		String excludeTagsStr = ParamUtil.getString(renderRequest, "excludeTags", StringPool.BLANK);
		
		String[] sourceFields = sourceFieldStr.split(StringPool.COMMA);
		String[] typeFields = typeFieldStr.split(StringPool.COMMA);
		String[] stageFields = stageFieldStr.split(StringPool.COMMA);
		String[] hotIdeasFields = hotIdeasFieldStr.split(StringPool.COMMA);
		String[] includeTags = includeTagsStr.split(StringPool.COMMA);
		String[] excludeTags = excludeTagsStr.split(StringPool.COMMA);
		
		Hits hits = SearchUtil.advanceSearch(sourceFields, typeFields, stageFields, fieldFrom, fieldTo,
				hotIdeasFields, includeTags, excludeTags,  renderRequest, ((cur - 1) * delta), (((cur - 1) * delta)+ delta));
		
		String sourceField =  Arrays.toString(sourceFields);
		sourceField = sourceField.substring(1, sourceField.length()-1);
		
		String typeField =  Arrays.toString(typeFields);
		typeField = typeField.substring(1, typeField.length()-1);
		
		String stageField =  Arrays.toString(stageFields);
		stageField = stageField.substring(1, stageField.length()-1);
		
		String hotIdeasField =  Arrays.toString(hotIdeasFields);
		hotIdeasField = hotIdeasField.substring(1, hotIdeasField.length()-1);
		
		String includeTag =  Arrays.toString(includeTags);
		includeTag = includeTag.substring(1, includeTag.length()-1);
		
		String excludeTag =  Arrays.toString(excludeTags);
		excludeTag = excludeTag.substring(1, excludeTag.length()-1);
		
		model.addAttribute("sourceField", sourceField);
		model.addAttribute("typeField", typeField);
		model.addAttribute("stageField", stageField);
		model.addAttribute("hotIdeasField", hotIdeasField);
		model.addAttribute("fieldFrom", fieldFrom);
		model.addAttribute("fieldTo", fieldTo);
		model.addAttribute("includeTag", includeTag);
		model.addAttribute("excludeTag", excludeTag);
		
		HashMap<String, Integer> docsMap = SearchUtil.getDocsMap(sourceFields, typeFields, stageFields, fieldFrom, fieldTo,
				hotIdeasFields, includeTags, excludeTags, renderRequest);
		
		model.addAttribute("hits", hits);
		model.addAttribute("docsMap", docsMap);
		
	}
	
	private void doFilterAdvanceSearch(RenderRequest renderRequest, Model model, int cur, int delta, String entryClassName){
		String sourceFieldStr = ParamUtil.getString(renderRequest, "sourceField", StringPool.BLANK);
		String typeFieldStr = ParamUtil.getString(renderRequest, "typeField", StringPool.BLANK);
		String stageFieldStr = ParamUtil.getString(renderRequest, "stageField", StringPool.BLANK);
		String fieldFrom = ParamUtil.getString(renderRequest, "fieldFrom", StringPool.BLANK);
		String fieldTo = ParamUtil.getString(renderRequest, "fieldTo", StringPool.BLANK);
		String hotIdeasFieldStr = ParamUtil.getString(renderRequest, "hotIdeasField", StringPool.BLANK);
		String includeTagsStr = ParamUtil.getString(renderRequest, "includeTags", StringPool.BLANK);
		String excludeTagsStr = ParamUtil.getString(renderRequest, "excludeTags", StringPool.BLANK);
		
		String[] filtersourceFields = new String[1];
		if(entryClassName.equals(DLFileEntry.class.getName())){
			filtersourceFields[0] = "Repository";
		}else if(entryClassName.equals(Solution.class.getName())){
			filtersourceFields[0] = "Solutions";
		}else if(entryClassName.equals(BlogsEntry.class.getName())){
			filtersourceFields[0] = "Website";
		}
		
		String[] sourceFields = sourceFieldStr.split(StringPool.COMMA);
		String[] typeFields = typeFieldStr.split(StringPool.COMMA);
		String[] stageFields = stageFieldStr.split(StringPool.COMMA);
		String[] hotIdeasFields = hotIdeasFieldStr.split(StringPool.COMMA);
		String[] includeTags = includeTagsStr.split(StringPool.COMMA);
		String[] excludeTags = excludeTagsStr.split(StringPool.COMMA);
		
		Hits hits = SearchUtil.advanceSearch(filtersourceFields, typeFields, stageFields, fieldFrom, fieldTo,
				hotIdeasFields, includeTags, excludeTags,  renderRequest, ((cur - 1) * delta), (((cur - 1) * delta)+ delta));
		
		String sourceField =  Arrays.toString(sourceFields);
		sourceField = sourceField.substring(1, sourceField.length()-1);
		
		String typeField =  Arrays.toString(typeFields);
		typeField = typeField.substring(1, typeField.length()-1);
		
		String stageField =  Arrays.toString(stageFields);
		stageField = stageField.substring(1, stageField.length()-1);
		
		String hotIdeasField =  Arrays.toString(hotIdeasFields);
		hotIdeasField = hotIdeasField.substring(1, hotIdeasField.length()-1);
		
		String includeTag =  Arrays.toString(includeTags);
		includeTag = includeTag.substring(1, includeTag.length()-1);
		
		String excludeTag =  Arrays.toString(excludeTags);
		excludeTag = excludeTag.substring(1, excludeTag.length()-1);
		
		model.addAttribute("sourceField", sourceField);
		model.addAttribute("typeField", typeField);
		model.addAttribute("stageField", stageField);
		model.addAttribute("hotIdeasField", hotIdeasField);
		model.addAttribute("fieldFrom", fieldFrom);
		model.addAttribute("fieldTo", fieldTo);
		model.addAttribute("includeTag", includeTag);
		model.addAttribute("excludeTag", excludeTag);
		
		HashMap<String, Integer> docsMap = SearchUtil.getDocsMap(sourceFields, typeFields, stageFields, fieldFrom, fieldTo,
				hotIdeasFields, includeTags, excludeTags, renderRequest);
		
		model.addAttribute("hits", hits);
		model.addAttribute("docsMap", docsMap);
	}
	
	/**
	 * @param actionRequest
	 * @param actionResponse
	 * @param model
	 */
	
	@ActionMapping(params = "action=search")
	public void searchAll(ActionRequest actionRequest, ActionResponse actionResponse,  Model model){
		
		int delta = 20;
		int cur = 1;
		
		String keywords = ParamUtil.getString(actionRequest, "keywords");
		actionResponse.setRenderParameter("keywords", keywords);
		actionResponse.setRenderParameter("delta", String.valueOf(delta));
		actionResponse.setRenderParameter("cur", String.valueOf(cur));
		model.addAttribute("keywords", keywords);
		model.addAttribute("delta", delta);
		model.addAttribute("cur", cur);
	}
	
	@ActionMapping(params = "action=advanceSearch")
	public void advanceSearch(ActionRequest actionRequest, ActionResponse actionResponse,  Model model){
		
		String[] sourceFields = ParamUtil.getParameterValues(actionRequest, "sourceField");
		String[] typeFields = ParamUtil.getParameterValues(actionRequest, "typeField");
		String[] stageFields = ParamUtil.getParameterValues(actionRequest, "stageField");
		String fieldFrom = ParamUtil.getString(actionRequest, "fieldFrom", StringPool.BLANK);
		String fieldTo = ParamUtil.getString(actionRequest, "fieldTo", StringPool.BLANK);
		String[] hotIdeasFields = ParamUtil.getParameterValues(actionRequest, "hotIdeasField");
		String[] includeTags = ParamUtil.getParameterValues(actionRequest, "includeTagsHidden");
		String[] excludeTags = ParamUtil.getParameterValues(actionRequest, "excludeTagsHidden");
		
		String sourceFieldstr =  Arrays.toString(sourceFields);
		sourceFieldstr = sourceFieldstr.substring(1, sourceFieldstr.length()-1);
		
		String typeFieldstr =  Arrays.toString(typeFields);
		typeFieldstr = typeFieldstr.substring(1, typeFieldstr.length()-1);
		
		String stageFieldstr =  Arrays.toString(stageFields);
		stageFieldstr = stageFieldstr.substring(1, stageFieldstr.length()-1);
		
		String hotIdeasFieldStr =  Arrays.toString(hotIdeasFields);
		hotIdeasFieldStr = hotIdeasFieldStr.substring(1, hotIdeasFieldStr.length()-1);
		
		String includeTagsStr =  Arrays.toString(includeTags);
		includeTagsStr = includeTagsStr.substring(1, includeTagsStr.length()-1);
		
		String excludeTagsStr =  Arrays.toString(excludeTags);
		excludeTagsStr = excludeTagsStr.substring(1, excludeTagsStr.length()-1);
		
		actionResponse.setRenderParameter("isAdvanceSearch", Boolean.TRUE.toString());
		actionResponse.setRenderParameter("sourceField", sourceFieldstr);
		actionResponse.setRenderParameter("typeField", typeFieldstr);
		actionResponse.setRenderParameter("stageField", stageFieldstr);
		actionResponse.setRenderParameter("fieldFrom",fieldFrom);
		actionResponse.setRenderParameter("fieldTo",fieldTo);
		actionResponse.setRenderParameter("hotIdeasField", hotIdeasFieldStr);
		actionResponse.setRenderParameter("includeTags", includeTagsStr);
		actionResponse.setRenderParameter("excludeTags", excludeTagsStr);
	}
	
	/**
	 * @param actionRequest
	 * @param actionResponse
	 * @param model
	 */
	@ActionMapping(params = "action=filter")
	public void searchFilter(ActionRequest actionRequest, ActionResponse actionResponse,  Model model){
		
		int delta = 20;
		int cur = 1;
		
		String entryClassName = ParamUtil.getString(actionRequest, "entryClassName");
		String keywords = ParamUtil.getString(actionRequest, "keywords");
		
		boolean isAdvanceSearch = ParamUtil.getBoolean(actionRequest, "isAdvanceSearch", Boolean.FALSE);
		String[] sourceFields = ParamUtil.getParameterValues(actionRequest, "sourceField");
		String[] typeFields = ParamUtil.getParameterValues(actionRequest, "typeField");
		String[] stageFields = ParamUtil.getParameterValues(actionRequest, "stageField");
		String fieldFrom = ParamUtil.getString(actionRequest, "fieldFrom", StringPool.BLANK);
		String fieldTo = ParamUtil.getString(actionRequest, "fieldTo", StringPool.BLANK);
		String[] hotIdeasFields = ParamUtil.getParameterValues(actionRequest, "hotIdeasField");
		String[] includeTags = ParamUtil.getParameterValues(actionRequest, "includeTags");
		String[] excludeTags = ParamUtil.getParameterValues(actionRequest, "excludeTags");
		
		actionResponse.setRenderParameter("keywords", keywords);
		actionResponse.setRenderParameter("isFilter", Boolean.TRUE.toString());
		actionResponse.setRenderParameter("entryClassName", entryClassName);
		actionResponse.setRenderParameter("delta", String.valueOf(delta));
		actionResponse.setRenderParameter("cur", String.valueOf(cur));
		
		String sourceFieldstr =  Arrays.toString(sourceFields);
		sourceFieldstr = sourceFieldstr.substring(1, sourceFieldstr.length()-1);
		
		String typeFieldstr =  Arrays.toString(typeFields);
		typeFieldstr = typeFieldstr.substring(1, typeFieldstr.length()-1);
		
		String stageFieldstr =  Arrays.toString(stageFields);
		stageFieldstr = stageFieldstr.substring(1, stageFieldstr.length()-1);
		
		String hotIdeasFieldStr =  Arrays.toString(hotIdeasFields);
		hotIdeasFieldStr = hotIdeasFieldStr.substring(1, hotIdeasFieldStr.length()-1);
		
		String includeTagsStr =  Arrays.toString(includeTags);
		includeTagsStr = includeTagsStr.substring(1, includeTagsStr.length()-1);
		
		String excludeTagsStr =  Arrays.toString(excludeTags);
		excludeTagsStr = excludeTagsStr.substring(1, excludeTagsStr.length()-1);
		 
		actionResponse.setRenderParameter("isAdvanceSearch", String.valueOf(isAdvanceSearch));
		actionResponse.setRenderParameter("sourceField", sourceFieldstr);
		actionResponse.setRenderParameter("typeField", typeFieldstr);
		actionResponse.setRenderParameter("stageField", stageFieldstr);
		actionResponse.setRenderParameter("fieldFrom",fieldFrom);
		actionResponse.setRenderParameter("fieldTo",fieldTo);
		actionResponse.setRenderParameter("hotIdeasField", hotIdeasFieldStr);
		actionResponse.setRenderParameter("includeTags", includeTagsStr);
		actionResponse.setRenderParameter("excludeTags", excludeTagsStr);
		
		model.addAttribute("entryClassName", entryClassName);
		model.addAttribute("keywords", keywords);
		model.addAttribute("delta", delta);
		model.addAttribute("cur", cur);
	}
	
	@ResourceMapping(value = "suggestWords")
	public void suggestWords(ResourceRequest request,
			ResourceResponse response,
			@RequestParam("searchChars") String searchChars) {
		
		searchChars = searchChars.trim();
		searchChars = searchChars.toLowerCase();
		JSONArray usersJSONArray = JSONFactoryUtil.createJSONArray();
		JSONObject userJSON = null;
		HashMap<String,Double> map = new HashMap<String,Double>();
		try {

			ModifiableSolrParams params = new ModifiableSolrParams();
			params = new ModifiableSolrParams();
			params.set("qt", "/terms");
		    params.set("terms.fl", "title");
		    params.set("terms.regex", searchChars + ".*");
		    params.set("omitHeader", "true");
		    
			try {
				QueryResponse queryResponse = solr.query(params);
			    for (Entry<String, List<Term>> l : queryResponse.getTermsResponse().getTermMap().entrySet()) {
				    for (Term s : l.getValue()) {
				    	if(!ArrayUtil.contains(ENGLISH_STOP_WORDS, l.getValue())) {
							map.put(SearchUtil.generateFirstLetterUpperCaseTerm(s.getTerm()), (double)s.getFrequency());
				    	}
					}
				}
			    
			} catch (SolrServerException e1) {
				_log.error(e1.getMessage() , e1);
			}
			String sChar = searchChars;
			String facetPrefix = null;
			String[] split = searchChars.split(" ");
			if(split.length > 1){
				sChar = split[0];
				facetPrefix = split[1];
			}
			
			
			//Searching most popular keywords
			if(Validator.isNull(facetPrefix)) {
				params = new ModifiableSolrParams();
				params.set("qt", "/select");
			    params.set("q", SearchController.SEARCHED_TITLE + ":"+searchChars+"*");
			    params.set("rows", "0");
			    params.set("wt", "json");
			    params.set("facet", "true");
			    params.set("facet.field", SearchController.SEARCHED_TITLE);
			    params.set("facet.prefix", searchChars);
			    params.set("omitHeader", "true");
			    params.set("facet.limit", 20);
			    params.set("facet.mincount", 1);
				try {
					QueryResponse queryResponse = solr.query(params);
				    for (FacetField l : queryResponse.getFacetFields()) {
					    for (Count s : l.getValues()) {
					    	if(!ArrayUtil.contains(ENGLISH_STOP_WORDS, s.getName())) {
					    		double count =  (double)s.getCount();
					    		if(map.containsKey(s.getName())) {
					    			count += map.get(s.getName());
									map.put(SearchUtil.generateFirstLetterUpperCaseTerm(s.getName()), count);
					    		}
					    	} 
						}
					}
				} catch (SolrServerException e1) {
					_log.error(e1.getMessage() , e1);
				}
			}
			
			params = new ModifiableSolrParams();
			params.set("qt", "/select");
		    params.set("q", "+(title:" + searchChars + "* OR content:" + searchChars + "*)");
		    params.set("rows", "0");
		    params.set("wt", "json");
		    params.set("facet", "true");
		    params.set("facet.field", "title");
		    if(Validator.isNotNull(facetPrefix)){
			    params.set("facet.prefix", facetPrefix);
		    }
		    params.set("omitHeader", "true");
		    params.set("facet.limit", 20);
		    params.set("facet.mincount", 1);
			try {
				QueryResponse queryResponse = solr.query(params);
			    for (FacetField l : queryResponse.getFacetFields()) {
				    for (Count s : l.getValues()) {
						if (s.getCount() > 0 && !s.getName().equalsIgnoreCase(sChar) && !ArrayUtil.contains(ENGLISH_STOP_WORDS, s.getName())) {
							map.put(SearchUtil.generateFirstLetterUpperCaseTerm(sChar) + " " + SearchUtil.generateFirstLetterUpperCaseTerm(s.getName()), (double)s.getCount());
						}
					}
				}
			} catch (SolrServerException e1) {
				_log.error(e1.getMessage() , e1);
			}
			ValueComparator bvc =  new ValueComparator(map);
	        TreeMap<String,Double> sortedMap = new TreeMap<String,Double>(bvc);
			sortedMap.putAll(map);
			for (Entry<String, Double> entry : sortedMap.entrySet()) {
				userJSON = JSONFactoryUtil.createJSONObject();
				userJSON.put("count", entry.getValue());
				userJSON.put("name", entry.getKey());
				usersJSONArray.put(userJSON);
				if (usersJSONArray.length() == 10) {
					break;
				}
			}
			
		} catch (Exception e) {
			_log.error(e.getMessage(), e);
		}
		try {
			response.getWriter().write(usersJSONArray.toString());
		} catch (IOException e) {
			_log.error(e.getMessage(), e);
		}
	}
	
	@ResourceMapping(value = "suggestTags")
	public void suggestTags(ResourceRequest request,
			ResourceResponse response,
			@RequestParam("searchChars") String searchChars) {
		searchChars = searchChars.trim();
		searchChars = searchChars.toLowerCase();
		JSONArray tagsJSONArray = JSONFactoryUtil.createJSONArray();
		JSONObject tagJSON = null;
		
		 List<AssetTag> assetTags = new ArrayList<AssetTag>();
		DynamicQuery query = DynamicQueryFactoryUtil.forClass(AssetTag.class);
				
		query.add(PropertyFactoryUtil.forName("name").like("%"+searchChars+"%"));
		 try {
			 assetTags =(List<AssetTag>) AssetTagLocalServiceUtil.dynamicQuery(query);
		 } catch (SystemException e) {
			_log.error("No Search Tags found");
		 }
		 try{
			 for(AssetTag assetTag : assetTags){
				 tagJSON = JSONFactoryUtil.createJSONObject();
				 tagJSON.put("name", assetTag.getName());
				 tagJSON.put("id", assetTag.getTagId());
				 tagsJSONArray.put(tagJSON);
			 }
		} catch (Exception e) {
			_log.error(e.getMessage(), e);
		}
		try {
			response.getWriter().write(tagsJSONArray.toString());
		} catch (IOException e) {
			_log.error(e.getMessage(), e);
		}
	}
}
