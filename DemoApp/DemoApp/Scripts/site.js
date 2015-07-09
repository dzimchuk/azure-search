function UpdateSortOption(option) {
    var displayOption = option.text() + "<span class=\"caret\"></span>";
    var sortOption = option.data("sort");
    $("#sortButton").html(displayOption);
    $("#sort").val(sortOption);
}

$(document).ready(function () {
    var options = $("#sortOptions li a ");

    options.on("click", function() {
        UpdateSortOption($(this));
    });

    var sort = $("#sort");
    for (var i = 0; i < options.length; i++) {
        var option = $(options[i]);
        if (sort.val() === option.data("sort")) {
            UpdateSortOption(option);
            break;
        }
    }
})