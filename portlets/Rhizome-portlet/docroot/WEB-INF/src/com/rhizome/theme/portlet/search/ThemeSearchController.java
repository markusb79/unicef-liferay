package com.rhizome.theme.portlet.search;

import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.util.ArrayUtil;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.util.PortalUtil;
import com.rhizome.portlet.search.SearchController;
import com.rhizome.util.SearchUtil;
import com.rhizome.util.ValueComparator;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.TreeMap;
import java.util.Map.Entry;

import javax.portlet.RenderRequest;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.solr.client.solrj.SolrServer;
import org.apache.solr.client.solrj.SolrServerException;
import org.apache.solr.client.solrj.impl.HttpSolrServer;
import org.apache.solr.client.solrj.response.FacetField;
import org.apache.solr.client.solrj.response.QueryResponse;
import org.apache.solr.client.solrj.response.FacetField.Count;
import org.apache.solr.client.solrj.response.TermsResponse.Term;
import org.apache.solr.common.params.ModifiableSolrParams;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.portlet.bind.annotation.RenderMapping;
import org.springframework.web.portlet.bind.annotation.ResourceMapping;

@Controller
@RequestMapping("VIEW")
public class ThemeSearchController {
	
	private static final Log _log = LogFactoryUtil.getLog(ThemeSearchController.class);
	
	private static final String VIEW_JSP = "view";

	private SolrServer solr = new HttpSolrServer(SearchUtil.getSOLRServerURL());
	
	public static final String[] ENGLISH_STOP_WORDS = {
	    "a", "an", "and", "are", "as", "at", "be", "but", "by",
	    "for", "i", "if", "in", "into", "is",
	    "no", "not", "of", "on", "or", "s", "such",
	    "t", "that", "the", "their", "then", "there", "these",
	    "they", "this", "to", "was", "will", "with"
	};
	
	@RenderMapping
	public String view(Locale locale, Model model, RenderRequest renderRequest) {	
		
		HttpServletRequest httpServletRequest = PortalUtil.getHttpServletRequest(renderRequest);
		return VIEW_JSP;
	}
	
	@ResourceMapping(value = "suggestWords")
	public void suggestWords(ResourceRequest request,ResourceResponse response) {
		
		String rhizomeThemeSearch = ParamUtil.getString(request, "inputNode");
		String searchChars = rhizomeThemeSearch.trim();
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
}
