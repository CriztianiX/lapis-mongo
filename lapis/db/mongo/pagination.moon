import Paginator from require "lapis.db.pagination"
math = math
class OffsetPaginator extends Paginator
    per_page: 10
    new: (@model, clause={}, opts={}) =>
        @_clause = clause
        @_opts = opts

    each_page: (starting_page=1) =>
        coroutine.wrap ->
            page = starting_page
            while true
                results = @get_page page
                break unless next results
                coroutine.yield results, page
                page += 1

    get_page: (page) =>
        page = tonumber page
        skip = if page > 1
            (page - 1) * @per_page
        else
            0

        _cursor = @model\_get_cursor(@_clause, @_opts)
        _cursor\limit @per_page
        _cursor\skip skip
        return _cursor\all!

    num_pages: =>
        math.ceil @total_items! / @per_page

    total_items: =>
      unless @_count
        @_count = @model\count @_clause
      @_count

{ :OffsetPaginator, :Paginator}