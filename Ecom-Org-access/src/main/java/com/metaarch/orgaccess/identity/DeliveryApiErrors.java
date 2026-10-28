package com.metaarch.orgaccess.identity;

import java.util.Map;
import java.util.LinkedHashMap;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestClientResponseException;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.dao.DataIntegrityViolationException;

@RestControllerAdvice(assignableTypes={DeliveryOperationsController.class,DeliveryPartnerController.class,StaffProfileController.class})
public class DeliveryApiErrors {
  private static final String MESSAGE = "message";
  private static final String STATUS = "status";

  private final ObjectMapper json;
  public DeliveryApiErrors(ObjectMapper json){this.json=json;}
  @ExceptionHandler(RestClientResponseException.class)
  public ResponseEntity<Map<String,Object>> upstream(RestClientResponseException error){
    String message="Delivery service could not complete this action.";
    try {
      var body=json.readTree(error.getResponseBodyAsString());
      if(body.hasNonNull(MESSAGE)) message=body.get(MESSAGE).asText();
    } catch(Exception ignored) {
      // Keep the generic message when the upstream response body is not JSON.
    }
    return ResponseEntity.status(error.getStatusCode()).body(Map.of(STATUS,error.getStatusCode().value(),MESSAGE,message));
  }
  @ExceptionHandler(ResponseStatusException.class)
  public ResponseEntity<Map<String,Object>> validation(ResponseStatusException error){
    return ResponseEntity.status(error.getStatusCode()).body(Map.of(STATUS,error.getStatusCode().value(),MESSAGE,error.getReason()==null?"Delivery action could not be completed.":error.getReason()));
  }
  @ExceptionHandler(MethodArgumentNotValidException.class)
  public ResponseEntity<Map<String,Object>> invalidFields(MethodArgumentNotValidException error){
    Map<String,String> fields = new LinkedHashMap<>();
    error.getBindingResult().getFieldErrors().forEach(field -> fields.putIfAbsent(field.getField(), field.getDefaultMessage()));
    return ResponseEntity.badRequest().body(Map.of(STATUS,400,MESSAGE,"Correct the highlighted fields and try again.","fields",fields));
  }
  @ExceptionHandler(DuplicateUserContactException.class)
  public ResponseEntity<Map<String,Object>> duplicateContacts(DuplicateUserContactException error){
    return ResponseEntity.status(HttpStatus.CONFLICT).body(Map.of(STATUS,409,MESSAGE,error.getMessage(),"fields",error.fields()));
  }
  @ExceptionHandler(DataIntegrityViolationException.class)
  public ResponseEntity<Map<String,Object>> duplicateDuringCreate(DataIntegrityViolationException error){
    return ResponseEntity.status(HttpStatus.CONFLICT).body(Map.of(STATUS,409,MESSAGE,
        "An account with one of these login or contact details already exists. Correct the highlighted fields and try again."));
  }
  @ExceptionHandler(RestClientException.class)
  public ResponseEntity<Map<String,Object>> unreachable(RestClientException error){
    return ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(Map.of(STATUS,502,MESSAGE,"The order or fulfilment service is unreachable. Ensure both services are running, then retry."));
  }
}
