<html> <!-- Using the html tags to create table with Target,Sucessor and Probability. -->
 <body>
  <table border = '1'>
  <tr>
  <th>Target</th>
  <th>Succesor</th>
  <th>Probability</th>
  </tr>
{ 
   let $data := for $file in collection('./?select=*.xml')//bncDoc           (: Using collection function to import all files. :)
 return $file
   let $w := $data//w
  let $target := ($data)//w[lower-case(normalize-space())="has"],            (: Matching the "has" in the words to find all the "has" appeared in the text after normalising and lowercase. :)
      $next_target := $target/lower-case(normalize-space(following-sibling::w[1])),    (: Finding the Successor to "has" in the words/corpus. :)
      $unique_next := distinct-values($next_target)                     (: Finding the distinct Successor using Distinct function. :)
      
  for $unique in $unique_next
  let $total := count($target/lower-case(normalize-space(following-sibling::w[1])) [.=$unique]),  (: Matching the distint Successor to all the Successor to find the total number of words after "has". :)
      $corpusmatch := count($w/lower-case(normalize-space(following-sibling::w[1]))[.=$unique]),  (: Matching to find the total Successor in the file even without following "has". :)
      $prob :=  $total div $corpusmatch                 (: Calculating the probability by the total Successors divided by the Successors after "has" :)
      order by $prob  descending                                        (: Using order function in descending order to probability so it return the probability in descending :)
  return <tr><td>{"has"}</td><td>{$unique}</td><td>{$prob}</td></tr>    (: Returning into the html table the Target, Successor and Probability :)
}   
  </table>
 </body>  <!-- Closing of html tags -->
</html>



