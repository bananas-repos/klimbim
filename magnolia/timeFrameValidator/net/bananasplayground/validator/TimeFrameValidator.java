package net.bananasplayground.validator;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.apache.commons.lang3.StringUtils;

import com.vaadin.data.ValidationResult;
import com.vaadin.data.ValueContext;
import com.vaadin.data.validator.AbstractValidator;

/**
 * Klimbim Software collection, A bag full of things
 * Copyright (C) 2011-2023 Johannes 'Banana' Keßler
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

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
