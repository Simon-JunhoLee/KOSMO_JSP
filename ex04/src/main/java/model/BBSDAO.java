package model;

import java.util.*;

public interface BBSDAO {
	public ArrayList<BBSVO> list(String title);
	public void insert(BBSVO vo);
	public BBSVO read(int bid);
	public void update(BBSVO vo);
	public void delete(int bid);
	public int page(String title);
}
