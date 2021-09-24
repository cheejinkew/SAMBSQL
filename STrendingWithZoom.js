// JScript File

    var xcount=0;
    var ycount=0;
    var clicked=false;
    var xdivcount=0;
    var ydivcount=0;
    var down=false;
    var x1;
    var y1;
    var x2;
    var y2;
    var width;
    var height;
    var maindivobj;
     
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
              var formobj=document.getElementById("STrendingWithZoom");
              document.getElementById("interval").value=document.getElementById("intervaldropdownlist").value;
              formobj.submit();
          }
    
    }
    function getyvalue(value)
    {
         ycount=ycount+1;
         if(ycount==1)
         {
            y1=value;
            //document.getElementById("ymin").value=value;
         }
         else if(ycount==2)
         {
            ycount=0;
            y2=value;
            document.getElementById("ymin").value=y1;
            document.getElementById("ymax").value=y2;
            
            var min=parseFloat(document.getElementById("ymin").value);
            var max=parseFloat(document.getElementById("ymax").value);
            if(min>max)
            {
                document.getElementById("ymin").value=max;
                document.getElementById("ymax").value=min;
                               
            }
            document.getElementById("operation").value="y";
            document.getElementById("interval").value=document.getElementById("intervaldropdownlist").value;
              var formobj=document.getElementById("STrendingWithZoom");
              formobj.submit();
         }
         
    }
     function intervalchange(obj)
    {
        document.getElementById("xys").value=document.getElementById("intervalcheck").value;
        var formobj=document.getElementById("STrendingWithZoom");
        document.getElementById("interval").value=obj.value;
        document.getElementById("operation").value="ic";
        formobj.submit();
        
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
    //document.getElementById("intervalselect").value=obj.value;
    }
    function imgdown(obj)
    {
        x1=event.offsetX;
        y1=event.offsetY;
        if(x1>85 && y1>70 && x1<635 && y1<350)
        {
            down=true;
        }
        maindivobj=document.getElementById("maindiv");
    }
    function imgup(obj)
    {
        if(down==true)
        {
            down=false;
            
            //alert("x1="+x1+" , y1="+y1+" , x2="+x2+" , y2="+y2);
             var intervaldivs=document.getElementById("intervaldivs");
             var obj=document.getElementById("intervalcheck");
             if(obj.value==1)
             {
                maindivobj.innerHTML=intervaldivs.innerHTML;
             }
             else
             {
             maindivobj.innerHTML="";
             maindivobj=null; 
             }
            
           
            var formobj=document.getElementById("STrendingWithZoom");
            if((x2-x1)>25 && (y2-y1)>25)
            {                                     
                document.getElementById("x1").value=x1;
                document.getElementById("y1").value=y1;
                document.getElementById("x2").value=x2;
                document.getElementById("y2").value=y2;
                document.getElementById("operation").value="zoom";
            
                formobj.submit();
            }
            else
            {
                if( x1<x2 && y1<y2)
                {
                    alert("please select zoom area > 25px");
                }
            }
         }
    }
    function imgmove(obj)
    {
        if(down==true)
        {
            x2=event.offsetX;
            y2=event.offsetY;
          if(x2<635 && y2<350 && x1<x2 && y1<y2)
          {
            width=x2-x1;
            height=y2-y1;
                
            maindivobj.innerHTML="<div id=\"rectdiv\" style=\"left:"+x1+"px;top:"+y1+"px;width:"+width+"px;height:"+height+"px;position:absolute;border: solid 1px red;filter:progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr='#20000077', EndColorStr='#20000077')\"></div>"
           }
       
        }
       
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
            var formobj=document.getElementById("STrendingWithZoom");
            document.getElementById("interval").value=document.getElementById("intervaldropdownlist").value;
            formobj.submit();
        }
    }
    function ydivover(obj)
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
    function ydivout(obj)
    {
        if(clicked==false)
        {
            obj.style.backgroundColor="silver";
        }
        clicked=false;
    }
    function ydivclick(value,obj)
    {
        ydivcount++;
            
        clicked=true;
        obj.style.backgroundColor="red";
       
         if(ydivcount==1)
         {
            y1=value;
            //document.getElementById("ymin").value=value;
         }
         else if(ydivcount==2)
         {
            ydivcount=0;
            y2=value;
            document.getElementById("ymin").value=y1;
            document.getElementById("ymax").value=y2;
            
            var min=parseFloat(document.getElementById("ymin").value);
            var max=parseFloat(document.getElementById("ymax").value);
            if(min>max)
            {
                document.getElementById("ymin").value=max;
                document.getElementById("ymax").value=min;
                               
            }
              document.getElementById("operation").value="y";
              var formobj=document.getElementById("STrendingWithZoom");
              formobj.submit();
         }
    }
    function adjustdiv()
    {
            var maindivobj=document.getElementById("maindiv");
            var agent = navigator.userAgent.toLowerCase();
            var appversion=navigator.appVersion;
            if(agent.indexOf("msie")>=0)
             {
            
            }
            else if(agent.indexOf("firefox")>=0)
            {
                 maindivobj.style.top="78px";
            }
            else if(agent.indexOf("opera")>=0)
            {
                maindivobj.style.top="78px";
            }
            else if(agent.indexOf("netscape")>=0)
            {
                 maindivobj.style.top="78px";
            }
            maindivobj.style.visibility="visible";
   }
   function btclick(obj)
   {
            obj.href+="&xys="+document.getElementById("intervalcheck").value;
   }
