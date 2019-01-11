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
        //��ȡ��Ŀ¼����Ӧ�ľ���·��
        String currentURL = request.getRequestURI();
        String targetURL = currentURL.substring(currentURL.indexOf("/",1),currentURL.length());
        
        //���session��Ϊ�վͷ��ظ�session�����Ϊ�վͷ���null
        HttpSession session = request.getSession(false);
        if(!"/load.jsp".equals(targetURL) && !"/forgot.jsp".equals(targetURL) && !"/Load_Forget.jsp".equals(targetURL)){
        	System.out.println(targetURL);
            //�жϵ�ǰҳ���Ƿ����ض��ΰ���ĵ�½ҳ��ҳ�棬����ǾͲ���session���жϣ���ֹ��ѭ��
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
