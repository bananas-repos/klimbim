package net.bananasplayground.validator;

import java.time.LocalDateTime;

import javax.inject.Inject;

import com.vaadin.data.Validator;

import info.magnolia.ui.field.AbstractFieldValidatorFactory;

/**
 * @see net.bananasplayground.validator.TimeFrameValidatorDefinition
 */

public class TimeFrameValidatorFactory extends AbstractFieldValidatorFactory<TimeFrameValidatorDefinition, LocalDateTime> {

    @Inject
    public TimeFrameValidatorFactory(TimeFrameValidatorDefinition definition) {
        super(definition);
    }

    @Override
    public Validator<LocalDateTime> createValidator() {
        return new TimeFrameValidator(getI18nErrorMessage(), definition);
    }
}
