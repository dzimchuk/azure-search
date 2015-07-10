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

function typeahead() {
    var azureSearch = new Bloodhound({
        datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
        queryTokenizer: Bloodhound.tokenizers.whitespace,
        remote: {
            url: 'home/suggest?searchText=%QUERY',
            wildcard: '%QUERY'
        }
    });


    $('#searchText').typeahead({
        hint: true,
        highlight: true,
        minLength: 3
    },
    {
        name: 'products',
        display: 'value',
        source: azureSearch
    });
}

$(document).ready(function () {
    setupSorting();
    typeahead();
})