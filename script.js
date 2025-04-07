
 // GO TO Line 337
} else if (option == "update_salary") {
    let grade = $(this).attr('data-grade');
    let gradeSalary = $('.bossmenu div[data-type="grades-manage"]>div>.side-boxes>div[data-type="grade"]>.data>#salary-settings>.settings>input').val();
    $.post(`https://${GetParentResourceName()}/updateGradeSalary`, JSON.stringify({
        grade: grade,
        salary: gradeSalary,
    }))

//  AND PAST AFTER THIS 

} else if (option == "launder-money") {
    let amount = parseInt($('.bossmenu div[data-type="money-laundering"] input#launder-amount').val());

    if (!amount || amount <= 0) {
        notify("❌ Montant invalide", "error");
        return;
    }

    let button = $(this);
    button.prop("disabled", true);

    $('.bossmenu .progress-container').remove();

    $('.bossmenu div[data-type="money-laundering"] .buttons').append(`
        <div class="progress-container">
            <div class="progress-bar"></div>
        </div>
    `);

    let progress = 0;
    let interval = setInterval(() => {
        progress += 2;
        $('.progress-bar').css('width', progress + '%');

        if (progress >= 200) { // Here you can change the value to 100 for 100% progress for time in milliseconds
            clearInterval(interval);
            $('.progress-container').remove();
            button.prop("disabled", false);
            $.post(`https://${GetParentResourceName()}/launderMoney`, JSON.stringify({
                amount: amount
            }));

            $('.bossmenu div[data-type="money-laundering"] input#launder-amount').val('');
        }
    }, 100);


    //