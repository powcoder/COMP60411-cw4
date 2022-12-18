import schema namespace uli = "http://www.cs.man.ac.uk/~sattler/" at "examSchema.xsd";
declare variable $examFile as xs:string external;

declare function local:markAB($answers as element()+, $grade as xs:decimal) as xs:decimal {
     (: You need to modify this function so that it marks all answers in an answersbook and 
        returns the grade the student got for all the answers given:) 
    0
};

declare function local:answerBookRow($ab as element(uli:AnswerBook), $passP, $totalMarks) as element()+ {
    (:  You need to modify this function so that it returns, per Student, 
        the required information as a row in the html table.  Note, it currently only
        evaluates to *one*, *fixed* row (which makes a good model), but you need to return
        *one row per input answerbook*.
        
        The value of the last cell should be the string "Pass" or the string "Fail" :)

        
        <tr>
            <td>
                { "S12345" }
            </td>
            <td>
                {13 }
            </td>       
            <td> 
                { "54%"}
            </td>
            <td>
                { "Pass" }
            </td>
        </tr>
};

declare function local:examResultsTable($exam, $passP, $totalMarks) { 
(: do not touch this function! :) 
        <table>
            <tr>
                <th>StudentID</th>
                <th>Raw Mark</th>  
                <th>Percentage Mark</th>
                <th>Pass/Fail?</th>
            </tr>
            { 
                for $AB in $exam//element(uli:AnswerBook)
                return local:answerBookRow($AB, $passP, $totalMarks)
            }
        </table>
};

declare function local:examResults($exam) {
    (: In the next two lines, replace the given numbers with suitable expressions; 
       otherwise, do not touch this function :) 
      let $totalMarks := 13
      let $passP := 54 
      return 
        <p>
            The total number of marks achievable is { $totalMarks } and you need
            { $passP }% of these to pass the exam. 
            {local:examResultsTable($exam, $passP, $totalMarks)}
        </p>
};

declare function local:examReport($exam) {
    (: Only touch this function in the one line indicated below:) 
    let $results := local:examResults($exam)
    return  
    <html>
        {(: in the line below, the two hard-coded strings need to be replaced with suitable expressions :)}
        <h1> Exam for { "Math101" } for the year for { "2021" }</h1> 
        
        <h2>Exam results</h2>
        {$results}
    </html>
};

(: Do not touch these two lines :) 
let $exam := (validate {doc($examFile)})/element(uli:Exam)
return local:examReport($exam)
