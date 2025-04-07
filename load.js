//ADD THIS ON LINE 297 
 


$('.bossmenu > div > .menu > .side-bar > div').hide();
$('.bossmenu').removeClass(function(index, className) {
    return className.split(' ').filter(cls => cls !== 'bossmenu').join(' ');
});
 //After this : Past here

if (this.HavePermission('moneyLaunderingAccess')) {
    firstMenu = 'money-laundering';
    $(`.bossmenu .menu > .side-bar > div[data-href="money-laundering"]`).show();
} else {
    $('.bossmenu').addClass('noMoneyLaunderingAccess');
}

// AND LINE 192 REPLACE FOR 
HavePermission: function(action) {
    if ((action == 'resumesAccess' || action == 'taxesAccess') && this.type == 'gang') return false;
    if (action == 'moneyLaunderingAccess' && this.type == 'gang') return false;
    if (action == 'safeTransfer' && !menuOptions[this.type]?.AllowAnyTransfers) return false;
    if (action == 'announcementsAccess' && !menuOptions[this.type]?.ShowAnnouncements) return false;

    return this.myPermissions == 'max' || this.myPermissions[action];
},