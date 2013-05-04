package silicon.cms.runtime.web.filter;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class RewriteFilter implements Filter
{
	private static Pattern _postURLPattern = null;
	private static Pattern _moreCategoryURLPattern = null;
	private static Pattern _moreSubcategoryURLPattern = null;
	private static Pattern _allURLPattern = null;
	
	@Override
	public void init(FilterConfig p_config) throws ServletException
	{
		if (_postURLPattern == null)
		{
			_postURLPattern = Pattern.compile("/([A-Z0-9]{32})/([a-z0-9]{31}).html");			
			_moreCategoryURLPattern = Pattern.compile("/([a-z]+)/more/([0-9]*)");
			_moreSubcategoryURLPattern = Pattern.compile("/([A-Z0-9]{32})/([A-Z0-9]{32})/more/([0-9]*)");
			_allURLPattern = Pattern.compile("/([0-9]+)");	
		}
	}

	@Override
	public void doFilter(ServletRequest p_request, ServletResponse p_response,
			FilterChain p_chain) throws IOException, ServletException
	{
		HttpServletRequest request = (HttpServletRequest)p_request;
		HttpServletResponse response = (HttpServletResponse)p_response;
		String uri = request.getRequestURI();
		
		Matcher matcher = null;
			
		if ((matcher = _postURLPattern.matcher(uri)).find())
		{
			String categoryId = matcher.group(1);
			String postId = matcher.group(2);
			
			request.getRequestDispatcher("/goods.jsp?id=" + postId + "&categoryId=" + categoryId).forward(request, response);
		}
		else if((matcher = _allURLPattern.matcher(uri)).find())
		{
			int pageIndex = 1;
			try
			{
				pageIndex = Integer.parseInt(matcher.group(1));
			}
			catch (Exception e) {}
			request.getRequestDispatcher("/?pageIndex=" + pageIndex).forward(request, response);
		}
		else if ((matcher = _moreCategoryURLPattern.matcher(uri)).find())
		{
			String categoryId = matcher.group(1);
			int pageIndex = 1;
			try
			{
				pageIndex = Integer.parseInt(matcher.group(2));
			}
			catch (Exception e) {}
			request.getRequestDispatcher("/more.jsp?categoryId=" + categoryId + "&pageIndex=" + pageIndex).forward(request, response);
		}
		else if ((matcher = _moreSubcategoryURLPattern.matcher(uri)).find())
		{
			String categoryId = matcher.group(1);
			String subcategoryId = matcher.group(2);
			int pageIndex = 1;
			try
			{
				pageIndex = Integer.parseInt(matcher.group(3));
			}
			catch (Exception e) {}
			request.getRequestDispatcher("/more.jsp?categoryId=" + categoryId + "&subcategoryId=" + subcategoryId + "&pageIndex=" + pageIndex).forward(request, response);
		}
		else if ((matcher = _moreCategoryURLPattern.matcher(uri)).find())
		{
			String categoryId = matcher.group(1);
			request.getRequestDispatcher("/more.jsp?categoryId=" + categoryId + "&pageIndex=1").forward(request, response);
		}
		else if ((matcher = _moreSubcategoryURLPattern.matcher(uri)).find())
		{
			String categoryId = matcher.group(1);
			String subcategoryId = matcher.group(2);
			request.getRequestDispatcher("/more.jsp?categoryId=" + categoryId + "&subcategoryId=" + subcategoryId + "&pageIndex=1").forward(request, response);
		}
		else
		{
			p_chain.doFilter(request, response);
		}
	}
	
	
	
	
	@Override
	public void destroy()
	{

	}

}
