package com.rhizome.service.impl;

import com.rhizome.dao.GenericDAO;
import com.rhizome.service.GenericService;

import java.io.Serializable;
import java.util.List;

/**
 * <p>
 * This is generic service implementation class and has all generic service
 * methods.
 * </p>
 * 
 * @author Chirag Soni
 */
public class GenericServiceImpl<T, PK extends Serializable> implements
		GenericService<T, PK> {

	private GenericDAO<T, PK> genericDAO;

	/* (non-Javadoc)
	 * @see com.unicef.service.GenericService#create(java.lang.Object)
	 */
	@Override
	public PK create(T t) {
		PK pk = genericDAO.create(t);
		return pk;
	}

	/* (non-Javadoc)
	 * @see com.unicef.service.GenericService#countAll()
	 */
	@Override
	public Integer countAll() {
		return genericDAO.countAll();
	}

	/* (non-Javadoc)
	 * @see com.unicef.service.GenericService#delete(java.io.Serializable)
	 */
	@Override
	public void delete(PK id) {
		T t = genericDAO.find(id);
		genericDAO.delete(t);
	}
	
	/*
	 * (non-Javadoc)
	 * 
	 * @see com.unicef.service.GenericService#find(java.io.Serializable)
	 */
	@Override
	public T find(PK id) {
		return genericDAO.find(id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see com.unicef.service.GenericService#findAll()
	 */
	@Override
	public List<T> findAll() {
		return genericDAO.findAll();
	}
	
	/* (non-Javadoc)
	 * @see com.unicef.service.GenericService#update(java.lang.Object)
	 */
	@Override
	public T update(T t) {
		t = genericDAO.update(t);
		return t;
	}

	/* (non-Javadoc)
	 * @see com.unicef.service.GenericService#finds(java.lang.String, boolean, int, int)
	 */
	@Override
	public List<T> finds(String orderParam, boolean desc, int first, int max) {
		return genericDAO.finds(orderParam, desc, first, max);
	}

	/**
	 * This method set genericDAO object.
	 * 
	 * @param genericDAO
	 */
	protected void setGenericDAOFactory(GenericDAO<T, PK> genericDAO) {
		this.genericDAO = genericDAO;
	}
}
