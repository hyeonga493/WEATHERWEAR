package com.w2.client.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.w2.cart.CartVO;
import com.w2.cart.service.CartService;
import com.w2.client.ClientVO;
import com.w2.product.OptionVO;
import com.w2.util.ClientCookie;
import com.w2.util.ResponseDTO;

@Controller
public class CartController {

	@Autowired
	private CartService cartService;
	
	/**
	 * 장바구니 화면 호출
	 * @param request
	 * @param session
	 * @param model
	 * @param cartvo
	 * @return
	 */
	@RequestMapping("cart.do")
	public String cart(HttpServletRequest request, HttpSession session, Model model, CartVO cartvo) {
		// 비로그인 상태인 경우
		if(session.getAttribute("userInfo") == null) {
			Cookie cookie = WebUtils.getCookie(request, "clientCookie");
			if (cookie != null) {
				cartvo.setCookieId((String)cookie.getValue());
			}
		} else {
			ClientVO client = (ClientVO) session.getAttribute("userInfo");
			cartvo.setClientId(client.getClientId());
		}
		
		List<CartVO> cartList = cartService.getCartList(cartvo);
		model.addAttribute("cartList", cartList);
		return "cart";
	}
	
	/** 
	 * 장바구니에 상품 추가
	 * @param productList
	 * @param session
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@PostMapping("cartInsert.do")
	public void cartInsert(@RequestBody List<CartVO> productList, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 비로그인 상태인 경우
		if(session.getAttribute("userInfo") == null) {
			String ckId = ClientCookie.setCookie(request, response);
			productList.get(0).setCookieId(ckId);
		} else { // 로그인 상태인 경우
			ClientVO client = (ClientVO) session.getAttribute("userInfo");
			productList.get(0).setClientId(client.getClientId());
		}
		
		int result = cartService.insertCart(productList);
		System.err.println("result : " + result);
		response.setContentType("application/json");
		response.getWriter().write(String.valueOf(result));
	}
	
	/** 
	 * 바로 주문하기
	 * @param productList
	 * @param session
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@PostMapping("buyNowProduct.do")
	public void buyNowProduct(@RequestBody List<CartVO> productList, HttpSession session, HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		// 비로그인 상태인 경우
		if(session.getAttribute("userInfo") == null) {
			String ckId = ClientCookie.setCookie(request, response);
			productList.get(0).setCookieId(ckId);
		} else { // 로그인 상태인 경우
			ClientVO client = (ClientVO) session.getAttribute("userInfo");
			productList.get(0).setClientId(client.getClientId());
		}
		
		CartVO cart = new CartVO();
		
		int result = cartService.insertCart(productList);
		
		response.setContentType("application/json");
		response.getWriter().write(String.valueOf(productList.get(0).getCartId()));
	}
	
	/** 
	 * 장바구니 수량 변경
	 * @param data
	 * @param session
	 * @param cartvo
	 * @param request
	 * @param response
	 * @throws IOException
	 */
	@PostMapping("cartUpdate.do")
	public void cartUpdate(@RequestBody Map<String, String> data, HttpSession session, CartVO cartvo, HttpServletRequest request, HttpServletResponse response) throws IOException {
		setUser(session, request, response, cartvo);
		cartvo.setCartId((String)data.get("cartId"));
		cartvo.setCartCnt(Integer.parseInt(data.get("cnt")));
		
		int result = cartService.updateCart(cartvo);

		setResponse(response, result, "application/json");
	}
	
	/** 
	 * 장바구니 상품 삭제
	 * @param checkList
	 * @param session
	 * @param cartvo
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@ResponseBody
	@PostMapping("cartDelete.do")
	public ResponseDTO<String> cartDelete(@RequestBody List<String> checkList, HttpSession session, CartVO cartvo, HttpServletRequest request, HttpServletResponse response) throws IOException {
		Integer statusCode = HttpStatus.OK.value();
		int code;
		String resultCode;
		String msg;
		
		try {
			int result = cartService.deleteCart(checkList);
			if(result > 0) {
				code = 1;
				resultCode = "success";
				msg = "삭제되었습니다.";
			} else {
				code = -1;
				resultCode = "fail";
				msg = "오류가 발생했습니다. 다시 시도해주세요";
			}
		} catch (Exception e) {
			e.printStackTrace();
			code = -1;
			resultCode = "fail";
			msg = "오류가 발생했습니다. 다시 시도해주세요";
		}
		return new ResponseDTO<String>(statusCode, code, resultCode, msg, null);
	}
	
	/** 
	 * 사용자 확인(회원/비회원)
	 * @param session
	 * @param request
	 * @param response
	 * @param cartvo
	 * @return
	 */
	public CartVO setUser(HttpSession session, HttpServletRequest request, HttpServletResponse response, CartVO cartvo) {
		// 비로그인 상태인 경우
		if(session.getAttribute("userInfo") == null) {
			String ckId = ClientCookie.setCookie(request, response);
			
			cartvo.setCookieId(ckId);
		} else { // 로그인 상태인 경우
			ClientVO client = (ClientVO) session.getAttribute("userInfo");
			cartvo.setClientId(client.getClientId());
		}
		return cartvo;
	}
	
	// ajax 응답
	public HttpServletResponse setResponse(HttpServletResponse response, Object result, String type) throws IOException {
		response.setContentType(type);
		response.getWriter().write(String.valueOf(result));
		
		return response;
	}
}
