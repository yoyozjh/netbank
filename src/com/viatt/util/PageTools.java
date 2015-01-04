package com.viatt.util;
public class PageTools {

	private StringBuffer pageRollStrBf = new StringBuffer();

	public String pageParam = "page";

	private int totalPage = 0;

	public int total = 0;

	public int pageSize = 15;

	private int totalshow = 10; 

	public int currPage = 0;

	public String url = "";
	
	
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	

	public int getPageSize() {
		return pageSize;
	}


	public void setTotal(int total) {
		this.total = total;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}
	
	public String pagegetRoll() {
		if (currPage > 0 && total > 0) {
			double d = total * 1.0 / pageSize;
			totalPage = (int) Math.ceil(d);
			if (totalPage >= currPage) {
				pageRollStrBf.append("<table border=0> <tr><td>");
				pageRollStrBf.append("共<span style='color:#0000ff'>" + total
						+ "</span>行&nbsp;&nbsp;&nbsp;");
				pageRollStrBf.append("共<span style='color:#0000ff'>"
						+ totalPage + "</span>页&nbsp;&nbsp;&nbsp;");
				pageRollStrBf.append("当前为第<span style='color:#FF0000'>"
						+ currPage + "</span>页&nbsp;&nbsp;&nbsp;");
				if (url.indexOf("?") == -1) {
					url += "?";
				}
				int tmp0 = url.indexOf(pageParam + "=");
				if (tmp0 != -1) {
					String fisrturl = url.substring(0, tmp0);
					String lasturl = "";
					String tmpurl = url.substring(tmp0);
					int tmp1 = tmpurl.indexOf("&");
					if (tmp1 != -1) {
						lasturl = tmpurl.substring(tmp1 + 1);
					}
					url = fisrturl + lasturl;
				}
				//url = url.replace("&&", "&");

				int n = 1;
				while (currPage > n * totalshow) {
					n++;
				}
				int firstpage = ((n - 1) * totalshow);
				int lastpage = ((n) * totalshow);

				if (firstpage > 0) {
					int page = firstpage;
					String tmpurl = url + "&page=" + page+"&actionType=pagegetRoll";
					//tmpurl = tmpurl.replace("&&", "&");
					pageRollStrBf
							.append("<a href='"
									+ tmpurl
									+ "'><span style='color:#FF0000'>|<<</span></a>&nbsp;");
				}
				for (int i = 1; (firstpage + i) < (totalPage + 1)
						&& i < (totalshow + 1); i++) {
					int page = firstpage + i;
					String tmpurl = url + "&page=" + page+"&actionType=pagegetRoll";
					//tmpurl = tmpurl.replace("&&", "&");
					pageRollStrBf.append("&nbsp;<a href='" + tmpurl
							+ "'><span style='color:"+((page==currPage)?"red":"#0000ff")+"'>[" + page
							+ "]</span></a>&nbsp;");
				}
				if (lastpage < totalPage) {
					int page = lastpage + 1;
					String tmpurl = url + "&page=" + page+"&actionType=pagegetRoll";
					//tmpurl = tmpurl.replace("&&", "&");
					pageRollStrBf
							.append("<a href='"
									+ tmpurl
									+ "'><span style='color:#FF0000'>>>|</span></a>&nbsp;");
				}
				pageRollStrBf.append("</td></tr></table>");
			}
		}
		return pageRollStrBf.toString();
	}


	public String getPageParam() {
		return pageParam;
	}


	public void setPageParam(String pageParam) {
		this.pageParam = pageParam;
	}


	public int getTotalPage() {
		return totalPage;
	}


	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}


	public int getTotalshow() {
		return totalshow;
	}


	public void setTotalshow(int totalshow) {
		this.totalshow = totalshow;
	}


	public int getCurrPage() {
		return currPage;
	}


	public int getTotal() {
		return total;
	}


	public String getUrl() {
		return url;
	}
}
