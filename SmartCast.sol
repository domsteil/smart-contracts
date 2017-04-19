c o n t r a c t SmartCast {
mapping ( a d d r e s s => u i n t ) p layermap ;
b o o l [ ] r e p o r t e d ;
a d d r e s s [ ] p l a y e r s ;
u i n t [ ] r ew a rd s ;
u i n t t h e t a ;
u i n t d e a d l i n e ; // D e ad l in e t o r e c e i v e r e p o r t s
f u n c t i o n a s s e r t ( b o o l b ) i n t e r n a l { i f ( ! b ) throw ; }
m o d i f i e r a f t e r ( u i n t T) { i f ( b l o c k . number >= T) ; e l s e throw ; }
m o d i f i e r b e f o r e ( u i n t T) { i f ( b l o c k . number < T) ; e l s e throw ; }
m o d i f i e r o n l y p l a y e r ( ) { i f ( p layermap [ msg . s e n d e r ] != 0 ) ; e l s e throw ; }
f u n c t i o n SmartCast ( a d d r e s s [ ] p l a y e r s , u i n t t h e t a , u i n t d e a d l i n e ) {
var N = p l a y e r s . l e n g t h ;
// Each p l a y e r e a r n s up t o N ∗ t h e t a i f th ey r e c e i v e a l l good r e p o r t s
a s s e r t (msg . v a l u e == N ∗ N ∗ t h e t a ) ;
t h e t a = t h e t a ;
d e a d l i n e = d e a d l i n e ;
f o r ( var p = 0 ; p < p l a y e r s . l e n g t h ; p++) {
p l a y e r s . push ( p l a y e r s [ p ] ) ;
r ew a rd s . push ( 0 ) ;
p layermap [ p l a y e r s [ p ] ] = ( p+1) ;
}
}
f u n c t i o n r e p o r t ( u i n t [ ] r e p o r t s ) o n l y p l a y e r b e f o r e ( d e a d l i n e ) {
var p = p layermap [ msg . s e n d e r ] − 1 ;
a s s e r t ( ! r e p o r t e d [ p ] ) ; r e p o r t e d [ p ] = t r u e ; // on l y r e p o r t on c e
a s s e r t ( p e n a l t i e s . l e n g t h == p l a y e r s . l e n g t h ) ;
f o r ( var q = 0 ; q < r e p o r t s . l e n g t h ; q++) {
var r e p o r t = r e p o r t s [ q ] ;
a s s e r t ( r e p o r t >= 0 ) ;
a s s e r t ( r e p o r t <= t h e t a ) ;
r ew a rd s [ q ] += r e p o r t ;
}
}
f u n c t i o n w ithdraw ( ) o n l y p l a y e r a f t e r ( d e a d l i n e ) {
var i = p layermap [ msg . s e n d e r ] − 1 ;
i f ( ! msg . s e n d e r . s end ( b a l a n c e [ i ] ) ) throw ;
b a l a n c e [ i ] = 0 ;
}
}