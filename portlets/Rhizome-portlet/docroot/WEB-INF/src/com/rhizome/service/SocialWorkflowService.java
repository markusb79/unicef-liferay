package com.rhizome.service;
import com.rhizome.domain.SocialWorkflow;

public interface SocialWorkflowService extends GenericService<SocialWorkflow, Long>  {

	SocialWorkflow findWorkflowFromSolutionId(Long solutionId);

}
