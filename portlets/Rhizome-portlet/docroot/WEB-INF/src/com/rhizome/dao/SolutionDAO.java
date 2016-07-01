package com.rhizome.dao;
import com.rhizome.domain.Solution;

import java.util.List;

public interface SolutionDAO extends GenericDAO<Solution, Long>{
	
	List<Solution> getRecentSolution();

	List<Solution> getRecentSolutionByPageNumber(long start, int recordsSize);
	
	public List<Solution> solutionList();
}
