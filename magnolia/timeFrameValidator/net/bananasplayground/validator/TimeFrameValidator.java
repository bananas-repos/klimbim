package net.bananasplayground.validator;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.apache.commons.lang3.StringUtils;

import com.vaadin.data.ValidationResult;
import com.vaadin.data.ValueContext;
import com.vaadin.data.validator.AbstractValidator;

/**
 * @see net.bananasplayground.validator.TimeFrameValidatorDefinition
 */

public class TimeFrameValidator extends AbstractValidator<LocalDateTime> {

    private final String errorMessage;
    private final TimeFrameValidatorDefinition definition;

    protected TimeFrameValidator(String errorMessage, TimeFrameValidatorDefinition definition) {
        super(errorMessage);
        this.errorMessage = errorMessage;
        this.definition = definition;
    }

    @Override
    public ValidationResult apply(LocalDateTime value, ValueContext context) {
        if(StringUtils.isAnyBlank(definition.getTimeTo(), definition.getTimeFrom())) return ValidationResult.ok();
        boolean isValid = false;

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        LocalDateTime timeFrom = LocalDateTime.parse(value.format(formatter) +"T"+definition.getTimeFrom());
        LocalDateTime timeTo = LocalDateTime.parse(value.format(formatter) +"T"+definition.getTimeTo());

        if((value.isEqual(timeFrom) || value.isAfter(timeFrom)) && (value.isEqual(timeTo) || value.isBefore(timeTo))) {
            isValid = true;
        }

        return isValid ? ValidationResult.ok() : ValidationResult.error(this.errorMessage);
    }
}
