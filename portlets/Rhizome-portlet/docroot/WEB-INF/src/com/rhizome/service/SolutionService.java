package com.rhizome.service;


import com.rhizome.domain.Solution;

import java.util.List;

public interface SolutionService extends GenericService<Solution, Long>{
	
	 List<Solution> getRecentSolution();

	List<Solution> getRecentSolutionByPageNumber(long start, int recordsSize);
	
	public List<Solution> solutionList();
	 
}
