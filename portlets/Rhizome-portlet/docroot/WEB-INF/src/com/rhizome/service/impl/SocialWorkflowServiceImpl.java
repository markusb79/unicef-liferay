package com.rhizome.service.impl;

import com.rhizome.dao.SocialWorkflowDAO;
import com.rhizome.domain.SocialWorkflow;
import com.rhizome.service.SocialWorkflowService;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

@Service
public class SocialWorkflowServiceImpl extends GenericServiceImpl<SocialWorkflow, Long> implements SocialWorkflowService{
	
	private SocialWorkflowDAO socialWorkflowDAO;
	
	@Inject
	public void initSocialWorkflowDAOFactory(SocialWorkflowDAO  socialWorkflowDAO) {
		this.socialWorkflowDAO = socialWorkflowDAO;
		setGenericDAOFactory(socialWorkflowDAO);
	}

	@Override
	public SocialWorkflow findWorkflowFromSolutionId(Long solutionId) {
		return socialWorkflowDAO.findWorkflowFromSolutionId(solutionId);
	}

}
