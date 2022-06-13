<html>
  <head>
    <title>"Top_20.xquery"</title>
  </head>
  <body>
   <table border="1">
     <tr>
       <th>Target</th>
	   <th>Successor</th>
	   <th>Probality</th>
	  </tr>
		 {
     if(not(collection('./?select=*.xml'))) then(<td bgcolor="red">Error!! No Input XML File Exists</td>)
     else ( 
       let $target := 'has',
           $corpus:= collection('./?select=*.xml')/*,       
           $top := 20,
           $words:= $corpus//w,                                              
		   $matched_words  := $words[lower-case(normalize-space()) =$target],
		   $successor := $matched_words/lower-case(normalize-space(following-sibling::w[1])) 
       let $sortResult := for $distinct_successor at $position in distinct-values($successor) 
           let $frequency := count($successor[. = $distinct_successor]),        
		       $total := count($words/lower-case(normalize-space(following-sibling::w[1]))[. = $distinct_successor]),                   
		       $probablity := ($frequency div $total)                                                                                  
           order by $probablity descending
           return ($distinct_successor, $probablity)
     for $count at $index in (1 to 2*$top)
            where (not($index mod 2 =0))
     return <tr>
		     <td>{$matched_words[$index]}</td>
			 <td>{$sortResult[$index]}</td>
			 <td>{fn:round($sortResult[$index+1],4)}</td>
           </tr>
      )
      }
		 </table>
    </body>
</html>




(:<html>
  <head>
    <title>"Top_20.xquery"</title>
  </head>
  <body>
   <table border="1">
     <tr>
        <th>Row</th>
       <th>Target</th>
	   <th>Successor</th>
	   <th>Probality</th>
	  </tr>
		 {
       let $target := 'has' ,                                             (: Define target word to be "has" :)
           $corpus:= collection('./?select=*.xml')/*,                        (: Read every content of all the xml files in the same folder :)              
           $words:= $corpus//w,                                              (: Extract all the word tags in the corpus :)
		   $matched_words  := $words[lower-case(normalize-space()) =$target] (: normalize to remove empty spaces and lowercase :)
         for $distinct_successor at $position in distinct-values($matched_words /lower-case(normalize-space(following-sibling::w[1]))) (: Get the disctinct successors of our target :)
		     let $frequency := count($matched_words/lower-case(normalize-space(following-sibling::w[1]))[. = $distinct_successor]),        (: count the frequency of our successor's appearance :)
		         $total := count($words/lower-case(normalize-space(following-sibling::w[1]))[. = $distinct_successor]),                    (: count the total apperance of our successor word :)
		         $probaliblity := ($frequency div $total)                                                                                  (: Compute probality as frequency/total formatted to two decimal places :)
             order by $probaliblity descending  (: Order our return in descending order of probablity :)
             let $a := tokenize(fn:string($position)),
                 $b := tokenize($matched_words[$position]),
                 $c := tokenize($distinct_successor),
                 $d := tokenize(fn:string($probaliblity))
            return
		   <tr>
		     <td>{ $position}</td>
		     <td>{ $b[$position] } </td>
			 <td>{ $c[$position] } </td>
			 <td>{ $d[$position]}</td> 
           </tr>
            }
		 </table>
    </body>
</html>



:)


(:<html>
  <head>
    <title>"Top_20.xquery"</title>
  </head>
  <body>
   <table border="1">
     <tr>
       <th>Target</th>
	   <th>Successor</th>
	   <th>Probality</th>
	   <th>Row 4 Prob</th>
	  </tr>
		 {
       let $target := 'has',
           $top := 20,
           $corpus:= collection('./?select=*.xml')/*,              
           $words:= $corpus//w,                                              
		   $matched_words  := $words[lower-case(normalize-space()) =$target],
		   $successor := $matched_words/lower-case(normalize-space(following-sibling::w[1])) 
       let $sortResult := for $distinct_successor at $position in distinct-values($successor) 
           let $frequency := count($successor[. = $distinct_successor]),        
		       $total := count($words/lower-case(normalize-space(following-sibling::w[1]))[. = $distinct_successor]),                   
		       $probablity := ($frequency div $total)                                                                                     
           order by $probablity descending
           return concat($distinct_successor,$probablity)
     for $count at $index in subsequence($sortResult,1, $top)
     return <tr>
		     <td>{$matched_words[$index]}</td>
			 <td>{$count[$index]}</td>
			 <td>{}</td>
			 <td>{}</td>
           </tr>
      }
		 </table>
    </body>
</html>
:)