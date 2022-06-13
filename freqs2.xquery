<html> <!-- Using the html tags to create table with Target,Sucessor and Frequency. -->
 <body>
  <table border='1'>
  <tr>
  <th>Target</th>
  <th>Succesor</th>
  <th>Frequency</th>
  </tr>
{      
let $data := for $file in collection('./?select=*.xml')//bncDoc               (: Using collection function to import all files. :)
 return $file
  let $target :=($data)//w[lower-case(normalize-space())="has"],              (: Matching the "has" in the words to find all the "has" appeared in the text after normalising and lowercase. :)
      $next_target := ($target/following-sibling::w[1]),                      (: Finding the Successor to "has" in the words/corpus. :)
      $unique_next := distinct-values($next_target)                           (: Finding the distinct Successor using Distinct function. :)
for $unique in $unique_next
  let $total := $next_target [.=$unique]                                      (: Finding the total  Successor which occure after "has". :)
order by (count($total))  descending                                          (: Using order by to return in descending order. :)
  return <tr><td>{"has"}</td><td>{$unique}</td><td>{count($total)}</td></tr>  (: Returning the has, Successor and Frequency. :)
}   
  </table> <!-- Closing of html tags -->
 </body>
</html>













