<html> <!-- Using the html tags to create table with Target and Successor. -->
 <body>
  <table border = '1'>
  <tr>
  <th>Target</th>
  <th>Succesor</th>
  </tr>
  
{ let $has := "has" 
 let $data := for $file in collection('./?select=*.xml')/bncDoc                        (: Using collection function to import all files. :)
 return $file
  for $word in $data//w                                                                (: Using data to import all words in word variable. :)   
  let $normalized := normalize-space(lower-case($word))                                (: Normalising the word with lowercase. :)
  where $normalized = $has                                                             (: Matching the "has" in the words to find all the "has" appeared in the text. :)
  let $next :=normalize-space($word/following-sibling::w[1])                           (: Finding the Successor to "has" in the words/corpus. :)
  
  return <tr><td>{$normalized}</td><td>{normalize-space(lower-case($next))}</td></tr>  (: Returning all the "has" in the corpus along with the Successor to the following has. :)
}   
  </table>
 </body>  <!-- Closing of html tags -->
</html>  