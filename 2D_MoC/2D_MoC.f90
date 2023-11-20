program Two_Dim_MoC
 implicit none
 real*8, parameter :: P0 = 1.6e6, T0 = 3.3e4, m_dot = 3.9, Pa = 1e5, gamma = 1.4, Cp = 2500, pi = 4*atan(1.), theta_ini = 0.2
 integer, parameter :: n = 100, nnode = 0.5*(n+3)*n
 integer :: i, j, node(nnode), w_n(0:n), c_n(n)
 real*8 :: R, At, Ae, Me, height_t, height_e, theta_max, d_theta, nu_e, Secant, alpha0_m(n), dydx0_m(n), width
 real*8, dimension(0:nnode) :: theta, alpha_m, dydx_m, x, y
 real*8, dimension(nnode)   :: Km, Kp, nu, M , mu, alpha_p, dydx_p
 integer, allocatable, dimension(:) :: m_n
 w_n = 0; Km = 0; Kp=0; x=0; y=0; theta=0; nu=0; M=0; mu=0; alpha_m=0; alpha_p=0; c_n=0; alpha0_m=0
   
 R = Cp*(gamma-1)/gamma
   
 At = (m_dot/P0)*sqrt(T0*R/gamma)*(2/(gamma+1))**(0.5*(gamma+1)/(gamma-1)) 
 height_t = sqrt(At); width = height_t ! assume square duct throat
    
 Me = sqrt( 2*((P0/Pa)**(1-1/gamma) -1)/(gamma-1))                                           
 Ae = (At/Me)*((2+(gamma-1)*Me**2)/(gamma+1))**(0.5*(gamma+1)/(gamma-1))
 height_e = Ae/width
    
     
 node = (/( i , i = 1,nnode )/)
 do i=1,n
     w_n(i) = w_n(i-1) + n - i + 2
 enddo
 c_n = w_n(0:n-1) + 1
   
 call Prantl_Meyer(Me,gamma, nu_e)
 theta_max = 0.5*nu_e; 
 d_theta = (theta_max - theta_ini)/(n-1)
     
 theta(0) = theta_max; theta(1:n) = (/( theta_ini + d_theta*(i-1) , i =1,n)/); theta(w_n(1)) = theta(n)
 nu(1:w_n(1)) = theta(1:w_n(1))
 Km(1:w_n(1)) = theta(1:w_n(1)) + nu(1:w_n(1))
 Kp(1:w_n(1)) = theta(1:w_n(1)) - nu(1:w_n(1))

 do i=2,n
     Km(c_n(i):w_n(i)) = Km(c_n(i-1)+1:w_n(i-1))
 enddo
 Kp(c_n) = -Km(c_n)

 do i=2,n
     Kp(c_n(i):w_n(i)) = Kp(c_n(i))
 enddo

 theta(1:nnode) = (Km + Kp)/2; nu = (Km - Kp)/2

 M = (/( Secant(1.03d0, 1d-5, 150, gamma, nu(i))   , i=1,nnode)/)
 mu = asin(1/M)*180./pi
    
 alpha0_m = theta(1:n) - mu(1:n)
 do i=1,n
     allocate(m_n(n-i+1))
     m_n = w_n(1:n-i+1)-i
     alpha_m(m_n(1:n-i)) = ( theta(m_n(1:n-i)) + theta(m_n(2:n-i+1)) - mu(m_n(1:n-i)) - mu(m_n(2:n-i+1)) )/2
     deallocate(m_n)
 enddo
 alpha_m(w_n(0:n-1)) = ( theta(w_n(0:n-1)) + theta(w_n(1:n)) )/2 ; alpha_m(w_n(n))=0.d0  ! wall
   
 do i=1,n
     alpha_p(c_n(i):w_n(i)-1) = ( theta(c_n(i):w_n(i)-1) + theta(c_n(i)+1:w_n(i)) + mu(c_n(i):w_n(i)-1) + mu(c_n(i)+1:w_n(i)) )/2 
 enddo
 alpha_p(w_n(1:n)) = alpha_p(w_n(1:n)-1); alpha_m(c_n) = -alpha_p(c_n)
   
 dydx_m = tan(alpha_m*pi/180); dydx_p = tan(alpha_p*pi/180); dydx0_m = tan(alpha0_m*pi/180)
      
 x(0)=0.d0;   y(0)=height_t/2;   y(1)=0.d0;  x(1) = -y(0)/dydx0_m(1)
   
 do i=2,n
     x(i) = (y(0)-y(i-1) + dydx_p(i-1)*x(i-1))/(dydx_p(i-1) - dydx0_m(i))
     y(i) = y(i-1) + dydx_p(i-1)*(x(i)-x(i-1))
 enddo
      
 do i=2,n
     y(c_n(i)) = 0.d0 ; x(c_n(i)) = x(c_n(i-1)+1) - y(c_n(i-1)+1)/dydx_m(c_n(i-1)+1)
     do j=c_n(i)+1,w_n(i)-1
         x(j) =(y(j-n+i-2) - y(j-1) + dydx_p(j-1)*x(j-1) - dydx_m(j-n+i-2)*x(j-n+i-2)) / ( dydx_p(j-1) - dydx_m(j-n+i-2))
         y(j) = dydx_p(j-1)*(x(j) - x(j-1)) + y(j-1)
     enddo
 enddo
   
 do i=1,n
     x(w_n(i)) = (y(w_n(i-1)) - y(w_n(i)-1) + dydx_p(w_n(i)-1)*x(w_n(i)-1) - &
                                              dydx_m(w_n(i-1))*x(w_n(i-1)))/(dydx_p(w_n(i)-1) - dydx_m(w_n(i-1)))
     y(w_n(i)) = y(w_n(i)-1) + dydx_p(w_n(i)-1)*(x(w_n(i)) - x(w_n(i)-1))
 enddo
   
 print*, y(w_n(n)),height_e/2
end program Two_Dim_MoC
      
subroutine Prantl_Meyer(mach,gam, pm)
 implicit none
 real*8 :: pm, mach,gam
 real*8, parameter :: pi = 4*atan(1.)
     
 pm = (sqrt((gam+1)/(gam-1))*atan( sqrt((mach**2-1)*(gam-1)/(gam+1)) ) - atan( sqrt(mach**2-1)) )*180./pi
end subroutine
      
function Secant(xx1,accu,MaxIter, gam,yy)
 implicit none
 real*8 :: xx1, accu, error, Secant, gam,yy,pm1,pm2
 integer :: MaxIter,i
 real*8, dimension(MaxIter+2) :: xx
      
 error = 1.d0 ; xx(1) = xx1 ; xx(2) = xx1+0.03 ; i= 1
      
 do while (error .GT. accu)
        
     call Prantl_Meyer(xx(i),gam,pm1)
     call Prantl_Meyer(xx(i+1),gam,pm2)
      
     xx(i+2)=(xx(i)*( pm2 - yy) - xx(i+1)*(pm1 - yy) ) / (pm2 - pm1)
     error=abs(yy - pm2); i=i+1
      
     if ( i .GT. MaxIter ) exit
 enddo
 Secant = xx(i+1)
end function
