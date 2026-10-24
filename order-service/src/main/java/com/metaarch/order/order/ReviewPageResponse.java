package com.metaarch.order.order;

import java.util.List;

public record ReviewPageResponse<T>(List<T> content, long totalElements, int totalPages, int size, int number) { }
