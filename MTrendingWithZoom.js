// JScript File
  var xcount=0;
  var y1count=0;
  var y2count=0;
  var y3count=0;
  var y4count=0;
  var xdivcount=0;
  var x1;
  var y1;
  var x2;
  var y2;
  var clicked=false;
  
  function getdate(date)
    {  
         xcount=xcount+1;
          if(xcount==1)
            document.getElementById("xmin").value=date;  
          else if(xcount==2)
          {
              xcount=0;
              document.getElementById("xmax").value=date;
              document.getElementById("operation").value="x";
              var formobj=document.getElementById("MTrendingWithZoom");
              document.getElementById("interval").value=document.getElementById("intervaldropdownlist").value;
              formobj.submit();
          }
    
    }
  function styleclick(style)
  {
    document.getElementById("style").value=style;
    var obj=document.getElementById("MTrendingWithZoom")
    obj.submit();
  }
  function over(obj)
  {
    obj.style.border="1px solid red";
       
  }
  function out(obj)
  {
   obj.style.border="1px solid #CBD6E4";
  }
  function intervalchange(obj)
  {
    document.getElementById("xys").value=document.getElementById("intervalcheck").value;
    var formobj=document.getElementById("MTrendingWithZoom");
    document.getElementById("interval").value=obj.value;
    document.getElementById("operation").value="ic";
    formobj.submit();
        
  }
   function back()
       {
            var formobj=document.getElementById("MTrendingWithZoom");
            formobj.action="TrendSelection.aspx";
            formobj.submit();
       }
       function over(obj,style)
       {
            obj.style.border="1px solid red";
            var imgdivobj=document.getElementById("imgdiv");
            switch (style) 
            {
            case 1 :
                imgdivobj.innerHTML="<img src=\"images/mtstyle1.gif\" alt=\"Line Chart\" style=\"width: 100px; height: 100px; cursor: hand;\" onclick=\"styleclick(6);\" />";
                break;
            case 2 :
               imgdivobj.innerHTML="<img src=\"images/mtstyle2.gif\" alt=\"3D Line Chart\" style=\"width: 100px; height: 100px; cursor: hand;\" onclick=\"styleclick(2);\" />";
               break;
            case 3 :
                imgdivobj.innerHTML="<img src=\"images/mtstyle3.gif\" alt=\"Area Chart\" style=\"width: 100px; height: 100px; cursor: hand;\" onclick=\"styleclick(6);\" />";
                break;
            case 4 :
                imgdivobj.innerHTML="<img src=\"images/mtstyle4.gif\" alt=\"3D Bar Chart\" style=\"width: 100px; height: 100px; cursor: hand;\" onclick=\"styleclick(6);\" />";
                break;
              
            } 
            imgdivobj.style.visibility="visible";
             
                 
       }
       function out(obj)
       {
            var imgdivobj=document.getElementById("imgdiv");
            imgdivobj.style.visibility="hidden";
            imgdivobj.innerHTML="";
            obj.style.border="1px solid #CBD6E4";
 
       }
   function selecty1(value)
    {
         y1count=y1count+1;
         if(y1count==1)
         {
            document.getElementById("y1min").value=value;
         }
         else if(y1count==2)
         {
            y1count=0;
            document.getElementById("y1max").value=value;
            
            var min=parseFloat(document.getElementById("y1min").value);
            var max=parseFloat(document.getElementById("y1max").value);
            if(min>max)
            {
                document.getElementById("y1min").value=max;
                document.getElementById("y1max").value=min;
                               
            }
            document.getElementById("operation").value="y";
            var formobj=document.getElementById("MTrendingWithZoom");
            formobj.submit();
         }
         
    }
    function selecty2(value)
    {
         y2count=y2count+1;
         if(y2count==1)
         {
            document.getElementById("y2min").value=value;
         }
         else if(y2count==2)
         {
            y2count=0;
            document.getElementById("y2max").value=value;
            
            var min=parseFloat(document.getElementById("y2min").value);
            var max=parseFloat(document.getElementById("y2max").value);
            if(min>max)
            {
                document.getElementById("y2min").value=max;
                document.getElementById("y2max").value=min;
                               
            }
            document.getElementById("operation").value="y";
            var formobj=document.getElementById("MTrendingWithZoom");
            formobj.submit();
         }
         
    }
    function selecty3(value)
    {
         y3count=y3count+1;
         if(y3count==1)
         {
            document.getElementById("y3min").value=value;
         }
         else if(y3count==2)
         {
            y3count=0;
            document.getElementById("y3max").value=value;
            
            var min=parseFloat(document.getElementById("y3min").value);
            var max=parseFloat(document.getElementById("y3max").value);
            if(min>max)
            {
                document.getElementById("y3min").value=max;
                document.getElementById("y3max").value=min;
                               
            }
            document.getElementById("operation").value="y";
            var formobj=document.getElementById("MTrendingWithZoom");
            formobj.submit();
         }
         
    }
    function selecty4(value)
    {
         y4count=y4count+1;
         if(y4count==1)
         {
            document.getElementById("y4min").value=value;
         }
         else if(y4count==2)
         {
            y4count=0;
            document.getElementById("y4max").value=value;
            
            var min=parseFloat(document.getElementById("y4min").value);
            var max=parseFloat(document.getElementById("y4max").value);
            if(min>max)
            {
                document.getElementById("y4min").value=max;
                document.getElementById("y4max").value=min;
                               
            }
            document.getElementById("operation").value="y";
            var formobj=document.getElementById("MTrendingWithZoom");
            formobj.submit();
         }
         
    }
    function intervalcheckclick(obj)
    {
    var maindivobj=document.getElementById("maindiv");
    var intervaldivs=document.getElementById("intervaldivs")
    var xys=document.getElementById("xys")
    if(obj.value==0)
    {
        obj.value=1;
        xys.value=obj.value;
        maindivobj.innerHTML=intervaldivs.innerHTML;
      
    }
    else
    {
        obj.value=0;
        xys.value=obj.value;
        intervaldivs.innerHTML=maindivobj.innerHTML;
        maindivobj.innerHTML="";
        
    }
    }
   function btclick(obj)
   {
            obj.href+="&xys="+document.getElementById("intervalcheck").value;
   }
   
    function xdivover(obj)
    {
       if(obj.style.backgroundColor=="red")
       {
         clicked=true;
       }
       else
       {
        obj.style.backgroundColor="red";
       }
    }
    function xdivout(obj)
    {
        if(clicked==false)
        {
             obj.style.backgroundColor="silver";
        }
        clicked=false;
    }
    function xdivclick(value,obj)
    {
        xdivcount++;
        clicked=true;
        obj.style.backgroundColor="red";
        if(xdivcount==1)
        {
            x1=value;
            //document.getElementById("xmin").value=value;
        }
        else if(xdivcount==2)
        {
            xcount=0;
            x2=value;
            document.getElementById("xmin").value=x1;
            document.getElementById("xmax").value=x2;
            document.getElementById("operation").value="x";
            var formobj=document.getElementById("MTrendingWithZoom");
            document.getElementById("interval").value=document.getElementById("intervaldropdownlist").value;
            formobj.submit();
        }
    }
   