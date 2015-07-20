function updateSortOption(option) {
    var displayOption = option.text() + "<span class=\"caret\"></span>";
    var sortOption = option.data("sort");
    $("#sortButton").html(displayOption);
    $("#sort").val(sortOption);
}

function setupSorting() {
    var options = $("#sortOptions li a ");

    options.on("click", function () {
        updateSortOption($(this));
    });

    var sort = $("#sort");
    for (var i = 0; i < options.length; i++) {
        var option = $(options[i]);
        if (sort.val() === option.data("sort")) {
            updateSortOption(option);
            break;
        }
    }
}

function autocomplete() {
    $("#searchText").autocomplete({
        minLength: 3,
        autoFocus: true,
        source: function(request, response) {
            $.getJSON("/home/suggest", {
                searchText: request.term
            }).done(function(data) {
                var array = data.error ? [] : $.map(data, function (item) {
                    return {
                        label: item.Text,
                        value: item.Text.replace(/<.+?>/ig, "")
                    };
                });
                response(array);
            });
        }
    }).autocomplete("instance")._renderItem = function(ul, item) {
        return $("<li>")
        .append("<span>" + item.label + "</span>")
        .appendTo(ul);
    };
}

function initializePager() {
    $(".pagination a").on("click", function() {
        $("#page").val($(this).data("page"));
        $("#search-form").submit();
        return false;
    });
}

function initializeFacets(selector, input) {
    $(selector).on("click", function () {
        $(input).val($(this).data("value"));
        $("#search-form").submit();
        return false;
    });
}

function initializePriceFacets(selector, inputFrom, inputTo) {
    $(selector).on("click", function () {
        $(inputFrom).val($(this).data("valuefrom"));
        $(inputTo).val($(this).data("valueto"));
        $("#search-form").submit();
        return false;
    });
}

$(document).ready(function () {
    setupSorting();
    autocomplete();

    initializePager();

    initializeFacets("#colors a", "#color");
    initializeFacets("#categories a", "#category");
    initializeFacets("#subcategories a", "#subcategory");
    initializePriceFacets("#prices a", "#priceFrom", "#priceTo");
})