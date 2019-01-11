package servlet;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class judgeloading
 */
@WebFilter("/judgeloading")
public class judgeloading implements Filter {

    /**
     * Default constructor. 
     */
    public judgeloading() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, 
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        //获取根目录所对应的绝对路径
        String currentURL = request.getRequestURI();
        String targetURL = currentURL.substring(currentURL.indexOf("/",1),currentURL.length());
        
        //如果session不为空就返回该session，如果为空就返回null
        HttpSession session = request.getSession(false);
        if(!"/load.jsp".equals(targetURL) && !"/forgot.jsp".equals(targetURL) && !"/Load_Forget.jsp".equals(targetURL)){
        	System.out.println(targetURL);
            //判断当前页面是否是重顶次昂后的登陆页面页面，如果是就不做session的判断，防止死循环
            if(session==null||session.getAttribute("loading")==null){
                response.sendRedirect(request.getContextPath()+"/load.jsp");
                return;
            }
        }
		
		// pass the request along the filter chain
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
