// CASEIN CUSTOM
// Use this file for your project-specific Casein JavaScript
function show_hide(id)
{
    switch(document.getElementById(id).style.display)
    {
        case 'block':
            document.getElementById(id).style.display = 'none';
            break;
        case 'none':
            document.getElementById(id).style.display = 'block';
            break;
    }
}


toggleDiv = function(div)
{

    switch ($("#"+div).css('display'))
    {
        case "none":
            $("#"+div).fadeIn(300);
            break;

        case "block":
            $("#"+div).fadeOut(300);
            break;
    }
}

toggleSwitchDiv = function(div1, div2)
{

    switch ($("#"+div1).css('display'))
    {
        case "none":
            $("#"+div1).fadeIn(100);
            $("#"+div2).fadeOut(100);
            break;

        case "block":
            $("#"+div1).fadeOut(100);
            $("#"+div2).fadeIn(100);
            break;
    }
}


