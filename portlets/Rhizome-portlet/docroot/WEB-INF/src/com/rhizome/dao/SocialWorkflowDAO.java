package com.rhizome.dao;

import com.rhizome.domain.SocialWorkflow;

public interface SocialWorkflowDAO  extends GenericDAO<SocialWorkflow, Long>{

	SocialWorkflow findWorkflowFromSolutionId(Long solutionId);


}
