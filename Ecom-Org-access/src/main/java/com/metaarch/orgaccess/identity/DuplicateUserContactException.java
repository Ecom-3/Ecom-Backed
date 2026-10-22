package com.metaarch.orgaccess.identity;

import java.util.Map;

/** A safe, field-specific conflict when a user contact is already claimed. */
public class DuplicateUserContactException extends RuntimeException {
  private final Map<String, String> fields;

  public DuplicateUserContactException(Map<String, String> fields) {
    super("Some contact details are already registered. Correct the highlighted fields and try again.");
    this.fields = Map.copyOf(fields);
  }

  public Map<String, String> fields() { return fields; }
}
